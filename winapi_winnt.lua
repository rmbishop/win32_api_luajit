--proc/winnt: don't know the scope of this yet.
setfenv(1, require'winapi_init')

FILE_ATTRIBUTE_READONLY             = 0x00000001
FILE_ATTRIBUTE_HIDDEN               = 0x00000002
FILE_ATTRIBUTE_SYSTEM               = 0x00000004
FILE_ATTRIBUTE_DIRECTORY            = 0x00000010
FILE_ATTRIBUTE_ARCHIVE              = 0x00000020
FILE_ATTRIBUTE_DEVICE               = 0x00000040
FILE_ATTRIBUTE_NORMAL               = 0x00000080
FILE_ATTRIBUTE_TEMPORARY            = 0x00000100
FILE_ATTRIBUTE_SPARSE_FILE          = 0x00000200
FILE_ATTRIBUTE_REPARSE_POINT        = 0x00000400
FILE_ATTRIBUTE_COMPRESSED           = 0x00000800
FILE_ATTRIBUTE_OFFLINE              = 0x00001000
FILE_ATTRIBUTE_NOT_CONTENT_INDEXED  = 0x00002000
FILE_ATTRIBUTE_ENCRYPTED            = 0x00004000
FILE_ATTRIBUTE_VIRTUAL              = 0x00010000

