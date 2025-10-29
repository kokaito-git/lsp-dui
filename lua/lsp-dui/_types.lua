-------------------------------------
--- LDM CORE MODULE
-------------------------------------
---@class LDCoreModule
---@field name string
---@field version fun(): string
---@field setup fun(opts: LDPluginOpts?): LDCoreModule
---@field restart fun(): nil
---@field api LDApiModule

-------------------------------------
--- LDM API
-------------------------------------
---@class LDApiModule
---@field name string
---@field shared LDSharedModule
---@field constants LDConstantsModule
---@field version fun(): string
---@field is_running fun(): boolean
---@field start fun(opts: LDPluginOpts?): nil
---@field stop fun(): nil
---@field restart fun(): nil
---@field opts fun(): LDInternalPluginOpts
---@field request_window fun(opts: LDRequestWindowOpts?): nil -- TODO: add return type

-------------------------------------
--- CLASSES
-------------------------------------

---@class LDApp
---@field new fun(): LDApp
---@field version fun(self: LDApp): string
---@field is_running fun(self: LDApp): boolean
---@field start fun(self: LDApp, opts: LDPluginOpts?): nil
---@field stop fun(self: LDApp): nil
---@field restart fun(self: LDApp): nil
---@field opts fun(self: LDApp): LDInternalPluginOpts
--- @field request_window fun(self: LDApp, opts: LDRequestWindowOpts?): nil -- TODO: return

-------------------------------------
--- OPTIONS
-------------------------------------
---@class LDPluginOpts

---@class LDInternalPluginOpts

---@class LDRequestWindowOpts

-------------------------------------
--- OTHER TYPES
-------------------------------------
