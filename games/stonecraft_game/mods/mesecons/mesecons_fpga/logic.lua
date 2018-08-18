local lg = {}

-- (de)serialize
lg.serialize = function(t)
	local function _op(t)
		if t == nil then
			return " "
		elseif t.type == "io" then
			return t.port
		else -- t.type == "reg"
			return tostring(t.n)
		end
	end
	local function _action(s)
		if s == nil then
			return " "
		end
		local mapping = {
			["and"] = "&",
			["or"] = "|",
			["not"] = "~",
			["xor"] = "^",
			["nand"] = "?", --dunno
			["buf"] = "_",
			["xnor"] = "=",
		}
		return mapping[s]
	end

	local s = ""
	for i = 1, 14 do
		local cur = t[i]
		if next(cur) ~= nil then
			s = s .. _op(cur.op1) .. _action(cur.action) .. _op(cur.op2) .. _op(cur.dst)
		end
		s = s .. "/"
	end
	return s
end

lg.deserialize = function(s)
	local function _op(c)
		if c == "A" or c == "B" or c == "C" or c == "D" then
			return {type = "io", port = c}
		elseif c == " " then
			return nil
		else
			return {type = "reg", n = tonumber(c)}
		end
	end
	local function _action(c)
		local mapping = {
			["&"] = "and",
			["|"] = "or",
			["~"] = "not",
			["^"] = "xor",
			["?"] = "nand",
			["_"] = "buf",
			["="] = "xnor",
			[" "] = nil,
		}
		return mapping[c]
	end

	local ret = {}
	for part in s:gmatch("(.-)/") do
		local parsed
		if part == "" then
			parsed = {}
		else
			parsed = {
				action = _action( part:sub(2,2) ),
				op1 = _op( part:sub(1,1) ),
				op2 = _op( part:sub(3,3) ),
				dst = _op( part:sub(4,4) ),
			}
		end
		ret[#ret + 1] = parsed
	end
	-- More than 14 instructions (write to all 10 regs + 4 outputs)
	-- will not pass the write-once requirement of the validator
	assert(#ret == 14)
	return ret
end

-- validation
lg.validate_single = function(t, i)
	local function is_reg_written_to(t, n, max)
		for i = 1, max-1 do
			if next(t[i]) ~= nil
					and t[i].dst and t[i].dst.type == "reg"
					and t[i].dst.n == n then
				return true
			end
		end
		return false
	end
	local function compare_op(t1, t2, allow_same_io)
		if t1 == nil or t2 == nil then
			return false
		elseif t1.type ~= t2.type then
			return false
		end
		if t1.type == "reg" and t1.n == t2.n then
			return true
		elseif t1.type == "io" and t1.port == t2.port then
			return not allow_same_io
		end
		return false
	end
	local elem = t[i]
	-- check for completeness
	if elem.action == nil then
		return {i = i, msg = "Gate type required"}
	elseif elem.action == "not" or elem.action == "buf" then
		if elem.op1 ~= nil or elem.op2 == nil or elem.dst == nil then
			return {i = i, msg = "Second operand (only) and destination required"}
		end
	else
		if elem.op1 == nil or elem.op2 == nil or elem.dst == nil then
			return {i = i, msg = "Operands and destination required"}
		end
	end
	-- check whether operands/destination are identical
	if compare_op(elem.op1, elem.op2) then
		return {i = i, msg = "Operands cannot be identical"}
	end
	if compare_op(elem.op1, elem.dst, true) or compare_op(elem.op2, elem.dst, true) then
		return {i = i, msg = "Destination and operands must be different"}
	end
	-- check whether operands point to defined registers
	if elem.op1 ~= nil and elem.op1.type == "reg"
			and not is_reg_written_to(t, elem.op1.n, i) then
		return {i = i, msg = "First operand is undefined register"}
	end
	if elem.op2.type == "reg" and not is_reg_written_to(t, elem.op2.n, i) then
		return {i = i, msg = "Second operand is undefined register"}
	end
	-- check whether destination points to undefined register
	if elem.dst.type == "reg" and is_reg_written_to(t, elem.dst.n, i) then
		return {i = i, msg = "Destination is already used register"}
	end

	return nil
end

lg.validate = function(t)
	for i = 1, 14 do
		if next(t[i]) ~= nil then
			local r = lg.validate_single(t, i)
			if r ~= nil then
				return r
			end
		end
	end
	return nil
end

-- interpreter
lg.interpret = function(t, a, b, c, d)
	local function _action(s, v1, v2)
		if s == "and" then
			return v1 and v2
		elseif s == "or" then
			return v1 or v2
		elseif s == "not" then
			return not v2
		elseif s == "xor" then
			return v1 ~= v2
		elseif s == "nand" then
			return not (v1 and v2)
		elseif s == "buf" then
			return v2
		else -- s == "xnor"
			return v1 == v2
		end
	end
	local function _op(t, regs, io_in)
		if t.type == "reg" then
			return regs[t.n]
		else -- t.type == "io"
			return io_in[t.port]
		end
	end

	local io_in = {A=a, B=b, C=c, D=d}
	local regs = {}
	local io_out = {}
	for i = 1, 14 do
		local cur = t[i]
		if next(cur) ~= nil then
			local v1, v2
			if cur.op1 ~= nil then
				v1 = _op(cur.op1, regs, io_in)
			end
			v2 = _op(cur.op2, regs, io_in)

			local result = _action(cur.action, v1, v2)

			if cur.dst.type == "reg" then
				regs[cur.dst.n] = result
			else -- cur.dst.type == "io"
				io_out[cur.dst.port] = result
			end
		end
	end
	return io_out.A, io_out.B, io_out.C, io_out.D
end

return lg
