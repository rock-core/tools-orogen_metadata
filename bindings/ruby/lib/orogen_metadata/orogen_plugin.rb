#to make the type known
require "orogen_metadata/metadata"

module Orocos
    module Spec
        class TaskContext
            attr_accessor :metadata

            def metadata_support
                if !find_extension("MetaDataPlugin")
                    register_extension(Orocos::Spec::MetaDataPlugin.new)
                end
            end

            def add_metadata(key,value)
                if(!metadata.metadata)
                    metadata.metadata = Typelib::MetaData.new
                end
                metadata.metadata.set(key,value.to_s)
            end

        end

        class ConfigurationObject
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
            def add_metadata(type,value)
                raise "Could not add metadata to port"
            end
        end


        class MetaDataPlugin < TaskModelExtension
            def name
                "MetaDataPlugin"
            end

            # Entry point for the orogen registration 
            def registered_on(task_context)
                task_context.metadata = OroGen::MetaData.new
                task_context.attribute("metadata","/metadata/TaskContext")
            end

            def generation_hook(task)
                code = Array.new
                code << "metadata::TaskContext md;"
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
