

require "metadata_types"

#binding.pry
STDOUT.puts "Loadingm etadata plugin for oorgen"

module Orocos

    module Generation
        class Project
        end
    end

    module Spec
        class TaskContext
            attr_accessor :metadata

            def metadata_support
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
                binding.pry
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


    module Generation
#        module PropertyGeneration
#            if metadata
#                task.in_
#            end
#        end
#
#        module InputPortGeneration
#            alias __metadata_orig_register_for_generation register_for_generation
#            def register_for_generation
#                __metadata_orig_register_for_generation
#                #TODO implement setting of default values
#                #task.in_base_hook('start',"#{cxx_default_value}")
#            end
#        end
    end
end
