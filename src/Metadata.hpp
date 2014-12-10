#ifndef OROGEN_METADATA_METADATA_HPP 
#define OROGEN_METADATA_METADATA_HPP

#include <vector>
#include <string>

namespace metadata {
    struct KeyValue
    {
        KeyValue(){}
        KeyValue(const std::string &key, const std::string &value): key(key),value(value){}
        std::string key;
        std::string value;
    };

    struct InterfaceObject
    {
        InterfaceObject(){}
        InterfaceObject(const std::string &name):name(name){}
        std::string name;
        std::vector<KeyValue> metadata;
    };

    struct TaskContext
    {
        std::vector<KeyValue> metadata;
        std::vector<InterfaceObject> properties;
        std::vector<InterfaceObject> input_ports;
        std::vector<InterfaceObject> output_ports;
    };
}

#endif
