FROM alpine:3.11

ENV STONECRAFT_GAME_VERSION master

COPY .git /usr/src/stonecraft/.git
COPY CMakeLists.txt /usr/src/stonecraft/CMakeLists.txt
COPY README.md /usr/src/stonecraft/README.md
COPY stonecraft.conf.example /usr/src/stonecraft/stonecraft.conf.example
COPY builtin /usr/src/stonecraft/builtin
COPY cmake /usr/src/stonecraft/cmake
COPY doc /usr/src/stonecraft/doc
COPY fonts /usr/src/stonecraft/fonts
COPY lib /usr/src/stonecraft/lib
COPY misc /usr/src/stonecraft/misc
COPY po /usr/src/stonecraft/po
COPY src /usr/src/stonecraft/src
COPY textures /usr/src/stonecraft/textures

WORKDIR /usr/src/stonecraft

RUN apk add --no-cache git build-base irrlicht-dev cmake bzip2-dev libpng-dev \
		jpeg-dev libxxf86vm-dev mesa-dev sqlite-dev libogg-dev \
		libvorbis-dev openal-soft-dev curl-dev freetype-dev zlib-dev \
		gmp-dev jsoncpp-dev postgresql-dev luajit-dev ca-certificates && \

WORKDIR /usr/src/
RUN git clone --recursive https://github.com/jupp0r/prometheus-cpp/ && \
	mkdir prometheus-cpp/build && \
	cd prometheus-cpp/build && \
	cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr/local \
		-DCMAKE_BUILD_TYPE=Release \
		-DENABLE_TESTING=0 && \
	make -j2 && \
	make install

WORKDIR /usr/src/stonecraft
RUN mkdir build && \
	cd build && \
	cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr/local \
		-DCMAKE_BUILD_TYPE=Release \
		-DBUILD_SERVER=TRUE \
		-DENABLE_PROMETHEUS=TRUE \
		-DBUILD_UNITTESTS=FALSE \
		-DBUILD_CLIENT=FALSE && \
	make -j2 && \
	make install

FROM alpine:3.11

RUN apk add --no-cache sqlite-libs curl gmp libstdc++ libgcc libpq luajit && \
	adduser -D stonecraft --uid 30000 -h /var/lib/stonecraft && \
	chown -R stonecraft:stonecraft /var/lib/stonecraft

WORKDIR /var/lib/minetest

COPY --from=0 /usr/local/share/stonecraft /usr/local/share/stonecraft
COPY --from=0 /usr/local/bin/stonecraftserver /usr/local/bin/stonecraftserver
COPY --from=0 /usr/local/share/doc/stonecraft/stonecraft.conf.example /etc/stonecraft/stonecraft.conf

USER stonecraft:stonecraft

EXPOSE 30000/udp 30000/tcp

CMD ["/usr/local/bin/stonecraftserver", "--config", "/etc/stonecraft/stonecraft.conf"]
