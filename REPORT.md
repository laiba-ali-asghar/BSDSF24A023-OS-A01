# Operating Systems Assignment 1 Report
**Name:** Laiba Ali Asghar  
**Roll No:** BSDSF24A023  

---

## Feature 2: Multi-file Project using Make
### 1. Linking rule $(TARGET):$(OBJECTS)
In the rule `$(TARGET): $(OBJECTS)`, the linker directly takes individual object files (`.o`) and combines them into a single binary executable. When linking directly against object files, all symbol addresses are resolved directly from those `.o` files. When linking against a library (`-Llib -lmyutils`), the linker searches through an archived library (`.a` or `.so`) and extracts/references only the symbols required by the application.

### 2. Git Tag vs. Annotated Tag
A Git tag is a reference point pointing to a specific commit in history.
- **Simple (Lightweight) Tag:** Just a pointer to a commit hash.
- **Annotated Tag:** Stored as a full object in the Git database containing the tagger's name, email, date, tagging message, and GPG signature capability. It is best practice for software releases.

### 3. Purpose of GitHub Release
A GitHub Release marks a versioned milestone of a project. Attaching compiled binaries allows end-users to download and execute the pre-built application directly without needing a full C build toolchain or source compilation setup.

---

## Feature 3: Static Library
### 1. Makefile comparison (Part 2 vs Part 3)
In Part 2, object files were directly linked to produce the executable. In Part 3, an intermediate static library target (`lib/libmyutils.a`) was introduced using `ar rcs`. The executable linking rule changed to use `-Llib -lmyutils`.

### 2. Purpose of `ar` and `ranlib`
`ar` (archiver) creates, modifies, and extracts static library archive (`.a`) files from individual object files. `ranlib` generates an index of symbols inside the static archive to speed up symbol lookups during linking (modern `ar` with `rcs` flags executes this automatically).

### 3. `nm` Analysis on Static Executable
When running `nm` on `bin/client_static`, symbols for functions like `mystrlen` are present in the text segment (`T`). This confirms that static linking copies the compiled machine code of library functions directly into the final executable.

---

## Feature 4: Dynamic Library
### 1. Position-Independent Code (-fPIC)
`-fPIC` generates machine code that executes independently of the memory address where it is loaded. It uses relative addressing via a Global Offset Table (GOT). This is mandatory for shared objects (`.so`) because multiple processes load the library into different memory spaces.

### 2. File Size Difference
`client_static` is larger because the library's machine code is embedded directly into the binary. `client_dynamic` is significantly smaller because it only contains dynamic symbol references resolved at runtime by the loader.

### 3. LD_LIBRARY_PATH & Dynamic Loader
`LD_LIBRARY_PATH` specifies non-standard directory paths where the operating system's dynamic linker/loader (`ld.so`) should search for shared object files (`.so`) at runtime before checking standard system paths (`/usr/lib`).
