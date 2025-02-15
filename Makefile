CXXFLAGS= -O3 -ffast-math -std=c++17 -march=x86-64 -Wall -fsigned-char

#set appropriate library includes
CLIENT_INCLUDES= -Igame -Ienet/include -I/usr/X11R6/include `sdl2-config --cflags`
CLIENT_LIBS= -lprimis -Lenet -lenet -L. -L/usr/X11R6/lib -lX11 `sdl2-config --libs` -lSDL2_image -lSDL2_mixer -lz -lGL -lGLEW

#list of source code files to be compiled
CLIENT_OBJS= \
	game/ai.o \
	game/client.o \
	game/cserver.o \
	game/crypto.o \
	game/edit.o \
	game/entities.o \
	game/game.o \
	game/gameclient.o \
	game/main.o \
	game/minimap.o \
	game/render.o \
	game/scoreboard.o \
	game/server.o \
	game/serverbrowser.o \
	game/waypoint.o \
	game/waypointai.o \
	game/weapon.o

default: client

#cleanup build files and executable
clean:
	-$(RM) -r $(CLIENT_OBJS) tess_client

#remove all of the assets required to build, just leaves what is needed to run program
remove-build-files:
	-$(RM) -r game/ vcpp/ bin64/ enet/ libprimis-headers/ .git/ .semaphore/ imprimis.bat .gitmodules Makefile

$(CLIENT_OBJS): CXXFLAGS += $(CLIENT_INCLUDES)

client:	libenet $(CLIENT_OBJS)
	$(CXX) $(CXXFLAGS) -o native_client $(CLIENT_OBJS) $(CLIENT_LIBS)

enet/libenet.a:
	$(MAKE) -C enet
libenet: enet/libenet.a
