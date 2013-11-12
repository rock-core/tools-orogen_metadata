#ifndef _WRAPPERS_HASH_MAP_
#define _WRAPPERS_HASH_MAP_

#include <vector>
#include <string>
#include <map>

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
        InterfaceObject(const std::string &name){}
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
/*
namespace wrappers{
    struct HashMap{
        struct StringPair{
            StringPair(){}
            StringPair(const std::string &a, const std::string &b):a(a),b(b){}

            std::string a;
            std::string b;
        };

        std::vector<StringPair> data;
    };
};
*/

#endif
