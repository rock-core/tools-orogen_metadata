require 'typelib'
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

        def pretty_print(pp)
            pp.text "Generic Metadata"
            pp.nest(2) do
                metadata.each do |key,value|
                    pp.breakable
                    pp.text "#{key} = #{value}"
                end
            end

            pp.breakable
            pp.text "Properties Metadata"
            properties.each do |k,v|
                pp.nest(2) do
                    pp.breakable
                    pp.text k
                    pp.nest(2) do
                        pp.breakable
                        v.each do |key,value|
                            pp.text "#{key} = #{value}"
                        end
                    end
                end
            end

            pp.breakable
            pp.text "Input Ports Metadata"
            input_ports.each do |k,v|
                pp.nest(2) do
                    pp.breakable
                    pp.text k
                    pp.nest(2) do
                        pp.breakable
                        v.each do |key,value|
                            pp.text "#{key} = #{value}"
                        end
                    end
                end
            end

            pp.breakable
            pp.text "Output Ports Metadata"
            output_ports.each do |k,v|
                pp.nest(2) do
                    pp.breakable
                    pp.text k
                    pp.nest(2) do
                        pp.breakable
                        v.each do |key,value|
                            pp.text "#{key} = #{value}"
                        end
                    end
                end
            end
        end
    end
end
