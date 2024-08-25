#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <stdio.h>

int main(int argc, char **argv) {
	if (argc != 2) {
		return 1;
	}

	if (geteuid() != 0) {
		printf("Not running as root");
		return 2;
	}

	if (setuid(0) == -1) {
        printf("Could not setuid");
        return 3;
    }

	if (!strncmp(argv[1], "connect_fastest", 15)) {
		system("protonvpn connect --fastest");
	}
	else if (!strncmp(argv[1], "connect_random", 14)) {
		system("protonvpn connect --random");
	}
	else if (!strncmp(argv[1], "disconnect", 10)) {
		system("protonvpn disconnect");
	}
	else {
		printf("Unknown command. Exiting.");
	}

	return 0;
}
