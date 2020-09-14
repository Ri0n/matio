# Check functions
include(CheckSymbolExists)
check_symbol_exists(vsnprintf  stdio.h    HAVE_VSNPRINTF)
check_symbol_exists(snprintf   stdio.h    HAVE_SNPRINTF)
check_symbol_exists(vasprintf  stdio.h    HAVE_VASPRINTF)
check_symbol_exists(asprintf   stdio.h    HAVE_ASPRINTF)
check_symbol_exists(strcasecmp "strings.h;string.h" HAVE_STRCASECMP)
check_symbol_exists(getopt     unistd.h   HAVE_GETOPT)
check_symbol_exists(va_copy    stdarg.h   HAVE_VA_COPY)
check_symbol_exists(__va_copy  stdarg.h   HAVE___VA_COPY)
check_symbol_exists(localeconv locale.h   HAVE_LOCALECONV)

include(CheckIncludeFile)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(stdint.h   HAVE_STDINT_H)
check_include_file(intsafe.h  HAVE_INTSAFE_H)
check_include_file(strings.h  HAVE_STRINGS_H)
check_include_file(ctype.h    HAVE_CTYPE_H)
check_include_file(stdlib.h   HAVE_STDLIB_H)
check_include_file(string.h   HAVE_STRING_H)
check_include_file(stdarg.h   HAVE_STDARG_H)
check_include_file(memory.h   HAVE_MEMORY_H)
check_include_file(unistd.h   HAVE_UNISTD_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(varargs.h  HAVE_VARARGS_H)
check_include_file(locale.h   HAVE_LOCALE_H)
check_include_file(dlfcn.h    HAVE_DLFCN_H)
set(MATIO_HAVE_STDINT_H ${HAVE_STDINT_H})
set(MATIO_HAVE_INTTYPES_H ${HAVE_INTTYPES_H})
if(NOT MATIO_HAVE_STDINT_H AND MSVC)
    set(STDINT_MSVC 1)
endif()

# Check C types
include(CheckTypeSize)
check_type_size(char          SIZEOF_CHAR)
check_type_size(double        SIZEOF_DOUBLE)
check_type_size(float         SIZEOF_FLOAT)
check_type_size(int           SIZEOF_INT)
check_type_size(long          SIZEOF_LONG)
check_type_size("long long"   SIZEOF_LONG_LONG)
check_type_size(short         SIZEOF_SHORT)
check_type_size(size_t        SIZEOF_SIZE_T)
check_type_size(intmax_t      INTMAX_T)
check_type_size(uintmax_t     UINTMAX_T)
check_type_size(uintptr_t     UINTPTR_T)
check_type_size(ptrdiff_t     PTRDIFF_T)
check_type_size("long double" LONG_DOUBLE)
check_type_size("long long int" LONG_LONG_INT)
check_type_size("unsigned long long int" UNSIGNED_LONG_LONG_INT)
set(SIZEOF_VOID_P ${CMAKE_SIZEOF_VOID_P})

# Make the variables HAVE_MAT_UINT8_T, etc...
set(TYPES uint8_t uint16_t uint32_t uint64_t int8_t int16_t int32_t int64_t)
foreach(TYPE ${TYPES})
    check_type_size(${TYPE} "SIZEOF_${TYPE}")
    set(_mat_${TYPE} ${TYPE})
    string(TOUPPER ${TYPE} TYPE_UPPER)
    set(HAVE_MAT_${TYPE_UPPER} ${HAVE_SIZEOF_${TYPE}})
    if(STDINT_MSVC)
        set(HAVE_MAT_${TYPE_UPPER} 1)
    endif()
endforeach()

include(CheckLibraryExists)
check_library_exists(m pow "" HAVE_LIBM)

include(CheckCSourceCompiles)
set(TEST_CODE_DECIMAL_POINT "
    #include <locale.h>
    int main() { struct lconv l; l.decimal_point; return 0; }
    "
)
check_c_source_compiles("${TEST_CODE_DECIMAL_POINT}" HAVE_STRUCT_LCONV_DECIMAL_POINT)

set(TEST_CODE_THOUSANDS_SEP "
    #include <locale.h>
    int main(){ struct lconv l; l.thousands_sep; return 0;}
    "
)
check_c_source_compiles("${TEST_CODE_THOUSANDS_SEP}" HAVE_STRUCT_LCONV_THOUSANDS_SEP)