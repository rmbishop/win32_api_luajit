win32_api_luajit
================

Tracking of Cosmin's win32 api for luajit (with adjustments)


Instructions for building a version of luajit with the library linked in:

1)Checkout files

2)Run build.bat

3)Link .o files to lua executable, ala:


    link.exe /out:luajit.exe luajit.obj lua51.lib winapi_*.o glue.o stddef_h.o systypes_h.o unit.o


4)Run luajit.exe test.lua


