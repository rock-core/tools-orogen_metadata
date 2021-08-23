cmake_minimum_required(VERSION 3.9)
project(orogen_metadata
        VERSION 0.1
        DESCRIPTION "type definitions for the metadata orogen plugin")

find_package(Rock)

rock_init()
rock_standard_layout()
include(RockRuby)
rock_ruby_library(bindings/ruby/lib/orogen_metadata)

install(FILES bindings/ruby/lib/orogen_metadata/typelib_plugin.rb DESTINATION
    share/typelib/ruby RENAME orogen_metadata.rb)
install(FILES bindings/ruby/lib/orogen_metadata/orogen_plugin.rb DESTINATION
    share/orogen/plugins RENAME orogen_metadata.rb)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/orogen_metadata.pc.in ${CMAKE_CURRENT_BINARY_DIR}/orogen_metadata.pc @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/orogen_metadata.pc DESTINATION lib/pkgconfig)
