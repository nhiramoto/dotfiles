local utils = {}

utils.with = function (module_name)

    local ok, module = pcall(require, module_name)
    local obj = {}
    obj.status_ok = ok
    obj.module = module

    obj.call = function (callback)
        if obj.status_ok then
            callback(module)
        else
            vim.notify('Error while importing module ' .. module_name .. '. ' .. module)
        end
    end

end

return utils
