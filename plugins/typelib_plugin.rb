

require "metadata_types"
STDOUT.puts "Loading metadada typelibn plugin"



Typelib.convert_to_ruby '/metadata/Component', Orocos::MetaData do |data|
    res = Orocos::MetaData.new
    data.metadata.each do |value|
        res.metadata.set(value.key,value.value)
    end
    data.output_ports.each do |value|
        #Value is a interface object
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            #value2 is a StringValue Pair
            v.set(value2.key,value2.value)
        end
        res.output_ports[value.name.to_s] = v
    end
    data.input_ports.each do |value|
        #Value is a interface object
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            #value2 is a StringValue Pair
            v.set(value2.key,value2.value)
        end
        res.input_ports[value.name.to_s] = v
    end
    data.properties.each do |value|
        #Value is a interface object
        v = Typelib::MetaData.new
        value.metadata.each do |value2|
            #value2 is a StringValue Pair
            v.set(value2.key,value2.value)
        end
        res.input_ports[value.name.to_s] = v
    end
    res
end

# Tell Typelib that Time instances can be converted into /base/Time values
Typelib.convert_from_ruby Orocos::MetaData, '/metadata/Component'  do |value, typelib_type|
    sample = typelib_type.new
    kv_class = Orocos.typelib_type_for("/metadata/KeyValue")
    io_class = Orocos.typelib_type_for("/metadata/InterfaceObject")
    value.metadata.each do |key,value|
        kv = kv_class.new
        kv.key = key
        kv.value = value
        sample.metadata << kv
    end
    value.output_ports.each do |key,value|
        io = io_class.new
        io.name = key
        value.each do |k,v|
            kv = kv_class.new
            kv.key = key
            kv.value = value
            io.metadata << kv
        end
        sample.output_ports << io
    end
    value.input_ports.each do |key,value|
        io = io_class.new
        io.name = key
        value.each do |k,v|
            kv = kv_class.new
            kv.key = key
            kv.value = value
            io.metadata << kv
        end
        sample.input_ports << io
    end
    sample
end

