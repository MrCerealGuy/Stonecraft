
-- Approximations for erf(x) and erfInv(x) from
-- https://en.wikipedia.org/wiki/Error_function

local statistics = {}
local random, floor, ceil = math.random, math.floor, math.ceil
local exp, log, sqrt = math.exp, math.log, math.sqrt
local ROOT_2 = sqrt(2.0)
local A = 8 * (math.pi - 3.0) / (3.0 * math.pi * (4.0 - math.pi))
local B = 4.0 / math.pi
local C = 2.0 / (math.pi * A)
local D = 1.0 / A


local function erf(x)

	if x == 0 then return 0 end

	local xSq  = x * x
	local aXSq = A * xSq
	local v = sqrt(1.0 - exp(-xSq * (B + aXSq) / (1.0 + aXSq)))

	return (x > 0 and v) or -v
end


local function erf_inv(x)

	if x == 0 then return 0 end

	if x <= -1 or x >= 1 then return nil end

	local y = log(1 - x * x)
	local u = C + 0.5 * y
	local v = sqrt(sqrt(u * u - D * y) - u)

	return (x > 0 and v) or -v
end


local function std_normal(u)
	return ROOT_2 * erf_inv(2.0 * u - 1.0)
end


local function generate_cdf(lambda_index, lambda)

	local max = ceil(4 * lambda)
	local pdf = exp(-lambda)
	local cdf = pdf
	local t = { [0] = pdf }

	for i = 1, max - 1 do
		pdf = pdf * lambda / i
		cdf = cdf + pdf
		t[i] = cdf
	end

	return t
end


local cdf_table = {}

for li = 1, 100 do
	cdf_table[li] = generate_cdf(li, 0.25 * li)
end


local function poisson(lambda, max)

	if max < 2 then
		return (random() < exp(-lambda) and 0) or 1
	elseif lambda >= 2 * max then
		return max
	end

	local u = random()
	local lambda_index = floor(4 * lambda + 0.5)
	local cdfs = cdf_table[lambda_index]

	if cdfs then

		lambda = 0.25 * lambda_index

		if u < cdfs[0] then return 0 end
		if max > #cdfs then max = #cdfs + 1 else max = floor(max) end
		if u >= cdfs[max - 1] then return max end

		if max > 4 then  -- Binary search

			local s = 0

			while s + 1 < max do

				local m = floor(0.5 * (s + max))

				if u < cdfs[m] then max = m else s = m end
			end
		else
			for i = 1, max - 1 do
				if u < cdfs[i] then return i end
			end
		end

		return max
	else
		local x = lambda + sqrt(lambda) * std_normal(u)

		return (x < 0.5 and 0) or (x >= max - 0.5 and max) or floor(x + 0.5)
	end
end

-- Error and Inverse error functions

statistics.erf = erf
statistics.erf_inv = erf_inv

--- Standard normal distribution function (mean 0, standard deviation 1).
 -- @return - Any real number (actually between -3.0 and 3.0).

statistics.std_normal = function()

	local u = random()

	if u < 0.001 then return -3.0 elseif u > 0.999 then return 3.0 end

	return std_normal(u)
end

--- Standard normal distribution function (mean 0, standard deviation 1).
 -- @param mu - The distribution mean.
 -- @param sigma - The distribution standard deviation.
 -- @return - Any real number (actually between -3*sigma and 3*sigma).

statistics.normal = function(mu, sigma)

	local u = random()

	if u < 0.001 then
		return mu - 3.0 * sigma
	elseif u > 0.999 then
		return mu + 3.0 * sigma
	end

	return mu + sigma * std_normal(u)
end

--- Poisson distribution function.
 -- @param lambda - The distribution mean and variance.
 -- @param max - The distribution maximum.
 -- @return - An integer between 0 and max (both inclusive).

statistics.poisson = function(lambda, max)

	lambda, max = tonumber(lambda), tonumber(max)

	if not lambda or not max or lambda <= 0 or max < 1 then return 0 end

	return poisson(lambda, max)
end

return statistics
