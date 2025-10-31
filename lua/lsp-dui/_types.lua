-------------------------------------
--- LDM CORE MODULE
-------------------------------------

---@class LDCoreModule
---@field name string
---@field version string
---@field api LDApiModule
---@field setup fun(opts: LDPluginOpts?): LDCoreModule

-------------------------------------
--- LDM API
-------------------------------------

---@class LDApiModule
---@field name string
---@field shared LDSharedModule
---@field constants LDConstantsModule
---@field version string
---@field is_running boolean
---@field opts LDInternalPluginOpts
---@field setup fun(opts: LDPluginOpts?): nil
---@field restart fun(): nil
---@field stop fun(): nil
---@field request_window fun(opts: LDRequestWindowOpts?): nil -- TODO: add return type

-------------------------------------
--- CLASSES
-------------------------------------

---@class LDApp
---@field new fun(): LDApp
---@field version string
---@field is_running boolean
---@field opts LDInternalPluginOpts
---@field start fun(self: LDApp, opts: LDPluginOpts?): nil
---@field stop fun(self: LDApp): nil
---@field restart fun(self: LDApp): nil
---@field request_window fun(self: LDApp, opts: LDRequestWindowOpts?): nil -- TODO: return

-------------------------------------
--- OPTIONS
-------------------------------------

---@class LDPluginOpts

---@class LDInternalPluginOpts

---@class LDRequestWindowOpts

-------------------------------------
--- OTHER TYPES
-------------------------------------
