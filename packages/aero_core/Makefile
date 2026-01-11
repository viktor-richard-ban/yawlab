# ---- Configuration ----
CXX      := clang++
AR       := ar
CXXFLAGS := -std=c++20 -O2 -Wall -Wextra -Wpedantic -Iinclude
LDFLAGS  :=

BUILD_DIR := build
LIB_NAME  := libaero_core.a

# Find all .cpp under src (including subfolders)
SRC_CPP := $(shell find src -name "*.cpp")
OBJ     := $(patsubst src/%.cpp,$(BUILD_DIR)/obj/%.o,$(SRC_CPP))

# Optional smoke test (C++ so it can link C++ runtime easily)
TEST_BIN := $(BUILD_DIR)/tests
TEST_SRC := tests/utilities_tests.cpp

# ---- Targets ----
.PHONY: all clean test

all: $(BUILD_DIR)/$(LIB_NAME)

# Build the static library from object files
$(BUILD_DIR)/$(LIB_NAME): $(OBJ)
	@mkdir -p $(BUILD_DIR)
	$(AR) rcs $@ $^

# Compile each .cpp -> .o (mirrors subfolders)
$(BUILD_DIR)/obj/%.o: src/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ---- Smoke test (links against the library) ----
test: $(TEST_BIN)
	$(TEST_BIN)

$(TEST_BIN): $(TEST_SRC) $(BUILD_DIR)/$(LIB_NAME)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< $(BUILD_DIR)/$(LIB_NAME) -o $@ $(LDFLAGS)

clean:
	rm -rf $(BUILD_DIR)
