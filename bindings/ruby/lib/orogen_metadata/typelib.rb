require "orogen_metadata/metadata"

Typelib.convert_to_ruby '/metadata/TaskContext', OroGen::MetaData do |data|
    res = OroGen::MetaData.new
    data.metadata.each do |value|
        res.metadata.set(value.key,value.value)
    end
    data.output_ports.each do |value|
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            v.set(value2.key,value2.value)
        end
        res.output_ports[value.name.to_s] = v
    end
    data.input_ports.each do |value|
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            v.set(value2.key,value2.value)
        end
        res.input_ports[value.name.to_s] = v
    end
    data.properties.each do |value|
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            v.set(value2.key,value2.value)
        end
        res.properties[value.name.to_s] = v
    end
    res
end

Typelib.convert_from_ruby OroGen::MetaData, '/metadata/TaskContext'  do |value, typelib_type|
    sample = typelib_type.new
    kv_class = Orocos.typelib_type_for("/metadata/KeyValue")
    io_class = Orocos.typelib_type_for("/metadata/InterfaceObject")
    value.metadata.each do |k, values|
        values.each do |v|
            sample.metadata << kv_class.new(:key => k, :value => v)
        end
    end
    value.properties.each do |name, md|
        io = io_class.new
        io.name = name
        md.each do |k, values|
            values.each do |v|
                io.metadata << kv_class.new(:key => k, :value => v)
            end
        end
        sample.properties << io
    end
    value.output_ports.each do |name, md|
        io = io_class.new
        io.name = name
        md.each do |k, values|
            values.each do |v|
                io.metadata << kv_class.new(:key => k, :value => v)
            end
        end
        sample.output_ports << io
    end
    value.input_ports.each do |name, md|
        io = io_class.new
        io.name = name
        md.each do |k, values|
            values.each do |v|
                io.metadata << kv_class.new(:key => k, :value => v)
            end
        end
        sample.input_ports << io
    end
    sample
end

