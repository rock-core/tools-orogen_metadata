#ifndef OROGEN_METADATA_METADATA_HPP 
#define OROGEN_METADATA_METADATA_HPP

#include <vector>
#include <string>

namespace metadata {
    struct KeyValue
    {
        KeyValue(){}
        KeyValue(const std::string &_key, const std::string &_value): key(_key),value(_value){}
        std::string key;
        std::string value;
    };

    struct InterfaceObject
    {
        InterfaceObject(){}
        InterfaceObject(const std::string &_name):name(_name){}
        std::string name;
        std::vector<KeyValue> metadata;
    };

    struct Component
    {
        std::vector<KeyValue> metadata;
        std::vector<InterfaceObject> properties;
        std::vector<InterfaceObject> input_ports;
        std::vector<InterfaceObject> output_ports;
    };
}

#endif
