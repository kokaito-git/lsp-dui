---@alias WindowType "line"|"buffer" Información de diagnóstico por línea o por buffer
---@alias WindowOrder "category"|"lines" Agrupación de diagnósticos por categoría o por línea

-- DuiApp módulo principal del plugin
---@class DuiCoreModule
---@field setup fun(args: DuiAppEntryOpts?): DuiApp Función para configurar el plugin
---@field app DuiApp Acceso a la instancia de la aplicación

-- Options para configurar el plugin
---@class DuiAppEntryOpts
---@field order? WindowOrder Cómo agrupar diagnósticos

-- Opciones internas de la aplicación
---@class DuiAppOpts
---@field order WindowOrder Cómo agrupar diagnósticos

---@class DuiApp
---@field new fun(): DuiApp
---@field is_running fun(self: DuiApp): boolean Devuelve true si la aplicación está en ejecución
---@field start fun(self: DuiApp, opts: DuiAppEntryOpts?): nil Inicia la aplicación
---@field stop fun(self: DuiApp): nil Detiene la aplicación
---@field restart fun(self: DuiApp, opts: DuiAppEntryOpts?): nil Reinicia la aplicación
---@field get_opts fun(self: DuiApp): DuiAppOpts Devuelve las opciones actuales de la aplicación

---@class WindowOpts
---@field wintype WindowType Tipo de ventana para mostrar diagnósticos (línea o buffer)
---@field order WindowOrder Cómo agrupar diagnósticos
---@field orig_bufid number Número del buffer original desde donde se invocó la ventana
---@field orig_winid number Número de la ventana original desde donde se invocó la ventana
---@field bufid number Número del buffer de nuestra ventana
---@field winid number Número de la ventana de nuestra ventana

---@class WindowManagerOpts

---@class WindowManager
---@field new fun(opts: WindowManagerOpts?): WindowManager Crea una nueva instancia de WindowManager
---@field is_running fun(self: WindowManager): boolean Devuelve true si el gestor de ventanas está en ejecución
---@field start fun(self: WindowManager): nil Inicia el gestor de ventanas
---@field stop fun(self: WindowManager): nil Detiene el gestor de ventanas

---@class WindowIDPackage
---@field new fun(orig_buf: number, orig_win: number, buf: number, win: number): WindowIDPackage Crea una nueva instancia de WindowIDPackage
---@field orig_buf number Devuelve el número del buffer original
---@field orig_win number Devuelve el número de la ventana original
---@field buf number Devuelve el número del buffer asociado
---@field win number Devuelve el número de la ventana asociada

---@class Window
---@field new fun(opts: WindowOpts?): Window Crea una nueva instancia de DuiWindow
---@field get_orig_bufid fun(self: Window): number Devuelve el buffer original
---@field get_orig_winid fun(self: Window): number Devuelve la ventana original
---@field get_bufid fun(self: Window): number Devuelve el buffer asociado a la ventana
---@field get_winid fun(self: Window): number Devuelve la ventana asociada
---@field get_wintype fun(self: Window): WindowType Devuelve el tipo de ventana
---@field get_order fun(self: Window): WindowOrder Devuelve el orden de agrupación
