---@alias WindowType "line"|"buffer" Información de diagnóstico por línea o por buffer
---@alias WindowOrder "category"|"lines" Agrupación de diagnósticos por categoría o por línea

-- DuiApp módulo principal del plugin
---@class DuiCoreModule
---@field setup fun(args: DuiAppOpts?): DuiApp Función para configurar el plugin
---@field app DuiApp (readonly) Instancia de la aplicación DuiApp.

-- Options para configurar el plugin
---@class DuiAppOpts
---@field order? WindowOrder Cómo agrupar diagnósticos

-- Opciones internas de la aplicación
---@class DuiAppInternalOpts
---@field order WindowOrder Cómo agrupar diagnósticos

---@class DuiApp
---@field new fun(): DuiApp
---@field is_running fun(self: DuiApp): boolean Devuelve true si la aplicación está en ejecución
---@field start fun(self: DuiApp, opts: DuiAppOpts?): nil Inicia la aplicación
---@field stop fun(self: DuiApp): nil Detiene la aplicación
---@field restart fun(self: DuiApp, opts: DuiAppOpts?): nil Reinicia la aplicación
---@field opts fun(self: DuiApp): DuiAppInternalOpts Devuelve una copia de las opciones actuales

---@class WindowManagerOpts

---@class WindowManager
---@field new fun(opts: WindowManagerOpts?): WindowManager Crea una nueva instancia de WindowManager
---@field is_running fun(self: WindowManager): boolean Devuelve true si el gestor de ventanas está en ejecución
---@field start fun(self: WindowManager): nil Inicia el gestor de ventanas
---@field stop fun(self: WindowManager): nil Detiene el gestor de ventanas

---@class WindowIdPkg
---@field new fun(orig_buf: number, orig_win: number, buf: number, win: number): WindowIdPkg Crea una nueva instancia de WindowIDPackage
---@field orig_buf fun(self: WindowIdPkg): number Devuelve el número del buffer original
---@field orig_win fun(self: WindowIdPkg): number Devuelve el número de la ventana original
---@field buf fun(self: WindowIdPkg): number Devuelve el número del buffer asociado
---@field win fun(self: WindowIdPkg): number Devuelve el número de la ventana asociada

---@class WindowOpts

---@class Window
---@field new fun(orig_buf: number, orig_win: number, opts: WindowOpts?): Window Crea una nueva instancia de Window
---@field winpkg fun(self: Window): WindowIdPkg Devuelve el paquete de identificación de la ventana
---@field orig_buf fun(self: Window): number Devuelve el número del buffer original
---@field orig_win fun(self: Window): number Devuelve el número de la ventana original
---@field buf fun(self: Window): number Devuelve el número del buffer asociado
---@field win fun(self: Window): number Devuelve el número de la ventana asociada
---@field wintype fun(self: Window): WindowType Devuelve el tipo de ventana
---@field winorder fun(self: Window): WindowOrder Devuelve el orden de agrupación de diagnósticos
