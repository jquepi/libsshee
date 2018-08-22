include(AddCCompilerFlag)
include(CheckCCompilerFlagSSP)

if (UNIX)
    add_c_compiler_flag("-std=gnu99" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-pedantic" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-pedantic-errors" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wall" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wshadow" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wmissing-prototypes" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wcast-align" SUPPORTED_COMPILER_FLAGS)
    #add_c_compiler_flag("-Wcast-qual" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=address" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wstrict-prototypes" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=strict-prototypes" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wwrite-strings" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=write-strings" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror-implicit-function-declaration" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wpointer-arith" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=pointer-arith" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wdeclaration-after-statement" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=declaration-after-statement" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wreturn-type" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=return-type" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wuninitialized" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=uninitialized" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wimplicit-fallthrough" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=strict-overflow" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wstrict-overflow=2" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wno-format-zero-length" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Wformat-security" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("-Werror=format-security" SUPPORTED_COMPILER_FLAGS)

    #
    # Check for -f options with -Werror turned on if possible
    #
    # This will prevent that compiler flags are detected incorrectly.
    #
    check_c_compiler_flag("-Werror" REQUIRED_FLAGS_WERROR)
    if (REQUIRED_FLAGS_WERROR)
        set(CMAKE_REQUIRED_FLAGS "-Werror")
    endif()

    add_c_compiler_flag("-fno-common" SUPPORTED_COMPILER_FLAGS)

    check_c_compiler_flag_ssp("-fstack-protector" WITH_STACK_PROTECTOR)
    if (WITH_STACK_PROTECTOR)
        list(APPEND SUPPORTED_COMPILER_FLAGS "-fstack-protector")
    endif()
    unset(CMAKE_REQUIRED_FLAGS)

    if (PICKY_DEVELOPER)
        add_c_compiler_flag("-Werror" SUPPORTED_COMPILER_FLAGS)
        add_c_compiler_flag("-Wno-error=deprecated-declarations" SUPPORTED_COMPILER_FLAGS)
        add_c_compiler_flag("-Wno-error=tautological-compare" SUPPORTED_COMPILER_FLAGS)
    endif()
endif()

if (MSVC)
    add_c_compiler_flag("/D _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=1" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("/D _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT=1" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("/D _CRT_NONSTDC_NO_WARNINGS=1" SUPPORTED_COMPILER_FLAGS)
    add_c_compiler_flag("/D _CRT_SECURE_NO_WARNINGS=1" SUPPORTED_COMPILER_FLAGS)
endif()

# This removes this annoying warning
# "warning: 'BN_CTX_free' is deprecated: first deprecated in OS X 10.7 [-Wdeprecated-declarations]"
if (OSX)
    add_c_compiler_flag("-Wno-deprecated-declarations" SUPPORTED_COMPILER_FLAGS)
endif()

if (BSD)
    # Allow zero for a variadic macro argument
    add_c_compiler_flag("-Wno-gnu-zero-variadic-macro-arguments" SUPPORTED_COMPILER_FLAGS)
endif()

set(DEFAULT_C_COMPILE_FLAGS ${SUPPORTED_COMPILER_FLAGS} CACHE INTERNAL "Default C Compiler Flags" FORCE)