function (CreatePkgConfigInfo filename)
    set(template_filename ${filename}.pc.in)
    if (EXISTS ${CMAKE_SOURCE_DIR}/${template_filename})
        set(PKGCONFIG_TEMPLATE ${CMAKE_SOURCE_DIR}/${template_filename})
    else()
        file(WRITE ${CMAKE_BINARY_DIR}/${template_filename} 
"# generated by cmake. remove this line to disable regeneration
prefix=@pkgconfig_prefix@
exec_prefix=\${prefix}
libdir=\${prefix}/@CMAKE_INSTALL_LIBDIR@
includedir=\${prefix}/@CMAKE_INSTALL_INCLUDEDIR@
confdir=\${prefix}/@CMAKE_INSTALL_LIBDIR@/@pkgconfig_package_name@

Name: @pkgconfig_package_name@
Description: @pkgconfig_package_description@
Version: @CPACK_PACKAGE_VERSION_MAJOR@.@CPACK_PACKAGE_VERSION_MINOR@.@CPACK_PACKAGE_VERSION_PATCH@
Requires: @PACKAGE_REQUIRES@
Libs: -L\${libdir} @PKGCONFIG_LIBS@
Cflags: -I\${includedir} -I\${confdir} @CPPFLAGS@")
        set(PKGCONFIG_TEMPLATE ${CMAKE_BINARY_DIR}/${template_filename})
    endif()

    set(pkgconfig_prefix ${CMAKE_INSTALL_PREFIX})
    set(pkgconfig_package_name "${CMAKE_PROJECT_NAME}")
    set(pkgconfig_package_description "${CPACK_PACKAGE_DESCRIPTION_SUMMARY}")

    configure_file(${PKGCONFIG_TEMPLATE} ${CMAKE_BINARY_DIR}/${filename}.pc @ONLY)
endfunction()
