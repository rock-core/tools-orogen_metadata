
require 'rorocos_ext'
require "metadata_types"

module Orocos
    class InputPort
        def default_value
            if task.metadata.input_ports[name]
                v = task.metadata.input_ports[name].get("default")
                return v[0] if v
            end
            nil
        end
    end

    class OutputPort
        def default_value
            if task.metadata.output_ports[name]
                v = task.metadata.output_ports[name].get("default")
                return v[0] if v
            end
            nil
        end
    end

    module Spec
        class TaskContext
            attr_accessor :metadata

            def metadata_support
                project.using_library "orogen_metadata"
                project.import_types_from "metadata/Metadata.hpp"
                register_extension(Orocos::Spec::MetaDataPlugin.new)
            end

            def add_metadata(key,value)
                if(!metadata.metadata)
                    metadata.metadata = Typelib::MetaData.new
                end
                metadata.metadata.set(key,value.to_s)
            end

        end

        class ConfigurationObject
            def scale(unit)
                add_metadata("unit",unit)
                self
            end

            def range(from,to)
                add_metadata("range","#{from}:#{to}")
                self
            end

            def add_metadata(type,value)
                if(!task.metadata.output_ports[name])
                    task.metadata.output_ports[name] = Typelib::MetaData.new
                end
                task.metadata.properties[name].set(type,value.to_s)
                self
            end
        end

        class OutputPort
            def add_metadata(type,value)
                if(!task.metadata.output_ports[name])
                    task.metadata.output_ports[name] = Typelib::MetaData.new
                end
                task.metadata.output_ports[name].set(type,value.to_s)
                self
            end
        end
        class InputPort
            def add_metadata(type,value)
                if(!task.metadata.input_ports[name])
                    task.metadata.input_ports[name] = Typelib::MetaData.new
                end
                task.metadata.input_ports[name].set(type,value.to_s)
                self
            end
        end

        class Port
            def unit(unit)
                add_metadata("unit",unit)
            end

            def range(from,to)
                add_metadata("range","#{from}:#{to}")
            end

            def default(value)
                add_metadata("default",value)
            end

            def scale(value)
                add_metadata("scale",value)
            end

            def range(from,to)
                add_metadata("range_from",from)
                add_metadata("range_to",to)
            end

            def add_metadata(type,value)
                raise "Could not add metadata to port"
            end
        end


        class MetaDataPlugin < TaskModelExtension
            # Entry point for the orogen registration 
            def registered_on(task_context)
                task_context.metadata = Orocos::MetaData.new
                task_context.property("metadata","/metadata/Component")
            end

            def register_for_generation(task)
                code = Array.new
                code << "metadata::Component md;"
                task.metadata.input_ports.each do |k,v|
                    code << "{"
                    code << "metadata::InterfaceObject io(\"#{k.to_s}\");"
                    v.each do |key,value|
                        code << "io.metadata.push_back(metadata::KeyValue(\"#{key.to_s}\",\"#{value[0].to_s}\"));"
                    end
                    code << "md.input_ports.push_back(io);"
                    code << "}"
                end
                task.metadata.output_ports.each do |k,v|
                    code << "{"
                    code << "metadata::InterfaceObject io(\"#{k.to_s}\");"
                    v.each do |key,value|
                        code << "io.metadata.push_back(metadata::KeyValue(\"#{key.to_s}\",\"#{value[0].to_s}\"));"
                    end
                    code << "md.output_ports.push_back(io);"
                    code << "}"
                end
                task.metadata.properties.each do |k,v|
                    code << "{"
                    code << "metadata::InterfaceObject io(\"#{k.to_s}\");"
                    v.each do |key,value|
                        code << "io.metadata.push_back(metadata::KeyValue(\"#{key.to_s}\",\"#{value[0].to_s}\"));"
                    end
                    code << "md.properties.push_back(io);"
                    code << "}"
                end
                task.metadata.metadata.each do |key,value|
                    code << "md.metadata.push_back(metadata::KeyValue(\"#{key.to_s}\",\"#{value[0].to_s}\"));"
                end
                code << "_metadata.set(md);"
                task.add_base_construction("void", "foo_bar_unused",code.join("\n"))
            end
        end
    end
end
