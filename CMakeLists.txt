PROJECT(orogen_metadata)
cmake_minimum_required(VERSION 2.6)

install(FILES lib/orogen_metadata/typelib_plugin.rb DESTINATION share/typelib/ruby RENAME metadata_typelib.rb)
install(FILES lib/orogen_metadata/orogen_plugin.rb DESTINATION share/orogen/plugins RENAME metadata_plugin.rb)
install(FILES include/Metadata.hpp DESTINATION include/orocos/metadata)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/orogen_metadata.pc.in ${CMAKE_CURRENT_BINARY_DIR}/orogen_metadata.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/orogen_metadata.pc DESTINATION lib/pkgconfig)
