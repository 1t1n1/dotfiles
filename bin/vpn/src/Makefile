# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -O2

# Target executable
TARGET = protonvpn_toggler

# Source file
SRCS = protonvpn_toggler.c

# Object file
OBJS = $(SRCS:.c=.o)

# Default target: build the executable
all: $(TARGET)

# Rule to build the executable
$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS)
	@echo -e "\nCompilation complete. Please run: sudo chown root:root protonvpn_toggler && sudo chmod u+s protonvpn_toggler"

# Rule to build object files from source files
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Clean up build files
clean:
	rm -f $(TARGET) $(OBJS)

# Phony targets
.PHONY: all clean

