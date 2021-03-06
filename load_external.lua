--
-- Main.lua
--
local lib; 
do
    local _start = os.clock();
    local function load_external_lua(path) 
        local buf = file.read(path);
        if buf == nil then
            return nil;
        end
        local _a = assert;
        local _s = loadstring;
        local export = _a(_s(buf));
        return export(); 
    end
    lib = load_external_lua("D:\\apps\\Nimsoft\\probes\\service\\nas\\lua_framework\\test.txt");
    if lib == nil then 
        exit(1); 
    else 
        print("Loading time : "..os.clock() - _start);
    end
end

local a = {
    foo = "bar"
}; 
print(lib.tdump(a));

--
-- External.lua
--
return (function () 

    local function tdump(t)
        local search = pairs;
        local sf = string.format;
        local sr = string.rep;
        local perf_type = type;
        local ts = tostring;
        local function dmp(t, l, k)
            if perf_type(t) == "table" then
                local msg = sf("%s%s:", sr(" ", l*2), ts(k));
                print(msg);
                for k, v in search(t) do
                    dmp(v, l+1, k);
                end
            else
                local msg = sf("%s%s:%s", sr(" ", l*2), ts(k), ts(t));
                print(msg);
            end
        end
        dmp(t, 1, "root");
    end

    local export = {
        tdump = tdump;
    }; 

    return export; 
end)(...)
