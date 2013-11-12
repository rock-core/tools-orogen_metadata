
STDOUT.puts "Loading metada types"
require "typelib/metadata"

module Orocos
    class MetaData
        # @return [Typelib::Metadata]
        attr_reader :metadata
        # @return [Hash<String,Typelib::Metadata>]
        attr_reader :properties
        # @return [Hash<String,Typelib::Metadata>]
        attr_reader :input_ports
        # @return [Hash<String,Typelib::Metadata>]
        attr_reader :output_ports

        def initialize
            @metadata = Typelib::MetaData.new
            @properties = Hash.new
            @input_ports = Hash.new
            @output_ports = Hash.new
        end

        def to_s
            s = String.new
            s << "Generic Metadata\n"
            metadata.each do |key,value|
                s << "\t#{key.to_s} = #{value.to_s}\n"
            end
            s << "Properties Metadata\n"
            properties.each do |k,v|
                v.each do |key,value|
                    s << "\t#{k.to_s}[#{key.to_s}] = #{value.to_s}\n"
                end
            end
            s << "Input Port Metadata\n"
            input_ports.each do |k,v|
                v.each do |key,value|
                    s << "\t#{k.to_s}[#{key.to_s}] = #{value.to_s}\n"
                end
            end
            s << "Output Port Metadata\n"
            output_ports.each do |k,v|
                v.each do |key,value|
                    s << "\t#{k.to_s}[#{key.to_s}] = #{value.to_s}\n"
                end
            end
            s
        end
    end
end
