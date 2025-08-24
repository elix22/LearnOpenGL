# - Try to find Assimp
# Once done, this will define
#
# ASSIMP_FOUND - system has Assimp
# ASSIMP_INCLUDE_DIR - the Assimp include directories
# ASSIMP_LIBRARIES - link these to use Assimp

# Platform-specific search paths with different priorities
if(WIN32)
	# On Windows, prioritize local includes and libraries
	FIND_PATH( ASSIMP_INCLUDE_DIR assimp/mesh.h
		${CMAKE_SOURCE_DIR}/includes
		/usr/local/include
		/usr/include
		/opt/local/include
	)
	FIND_LIBRARY( ASSIMP_LIBRARY assimp
		${CMAKE_SOURCE_DIR}/lib
		/usr/local/lib
		/usr/lib64
		/usr/lib
		/opt/local/lib
	)
elseif(APPLE)
	# On macOS, prioritize Homebrew installation and exclude local
	FIND_PATH( ASSIMP_INCLUDE_DIR assimp/mesh.h
		/opt/homebrew/include
		/opt/homebrew/opt/assimp/include
		/usr/local/include
		/usr/include
		/opt/local/include
		NO_DEFAULT_PATH
	)
	FIND_LIBRARY( ASSIMP_LIBRARY assimp
		/opt/homebrew/lib
		/opt/homebrew/opt/assimp/lib
		/usr/local/lib
		/usr/lib64
		/usr/lib
		/opt/local/lib
		NO_DEFAULT_PATH
	)
	# If not found in system paths, fall back to local
	if(NOT ASSIMP_INCLUDE_DIR)
		FIND_PATH( ASSIMP_INCLUDE_DIR assimp/mesh.h
			${CMAKE_SOURCE_DIR}/includes
		)
	endif()
	if(NOT ASSIMP_LIBRARY)
		FIND_LIBRARY( ASSIMP_LIBRARY assimp
			${CMAKE_SOURCE_DIR}/lib
		)
	endif()
else()
	# On Linux and other Unix systems, use standard paths
	FIND_PATH( ASSIMP_INCLUDE_DIR assimp/mesh.h
		/usr/local/include
		/usr/include
		/opt/local/include
		${CMAKE_SOURCE_DIR}/includes
	)
	FIND_LIBRARY( ASSIMP_LIBRARY assimp
		/usr/local/lib
		/usr/lib64
		/usr/lib
		/opt/local/lib
		${CMAKE_SOURCE_DIR}/lib
	)
endif()
IF(ASSIMP_INCLUDE_DIR AND ASSIMP_LIBRARY)
	SET( ASSIMP_FOUND TRUE )
	SET( ASSIMP_LIBRARIES ${ASSIMP_LIBRARY} )
ENDIF(ASSIMP_INCLUDE_DIR AND ASSIMP_LIBRARY)
IF(ASSIMP_FOUND)
	IF(NOT ASSIMP_FIND_QUIETLY)
	MESSAGE(STATUS "Found ASSIMP: ${ASSIMP_LIBRARY}")
	ENDIF(NOT ASSIMP_FIND_QUIETLY)
ELSE(ASSIMP_FOUND)
	IF(ASSIMP_FIND_REQUIRED)
	MESSAGE(FATAL_ERROR "Could not find libASSIMP")
	ENDIF(ASSIMP_FIND_REQUIRED)
ENDIF(ASSIMP_FOUND)
