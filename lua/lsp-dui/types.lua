---@alias WindowType "line"|"buffer" Información de diagnóstico por línea o por buffer
---@alias WindowOrder "category"|"lines" Agrupación de diagnósticos por categoría o por línea


-- DuiApp módulo principal del plugin
---@class DuiAppModule
---@field setup fun(args: DuiAppOpts?): nil Función para configurar el plugin
---@field app DuiApp Instancia de la aplicación

-- Options para configurar el plugin
---@class DuiAppOpts
---@field order? WindowOrder Cómo agrupar diagnósticos

---@class DuiApp
---@field new fun(self: DuiApp, opts: DuiAppOpts?): DuiApp
---@field is_running fun(self: DuiApp): boolean Devuelve true si la aplicación está en ejecución
---@field start fun(self: DuiApp): nil Inicia la aplicación
---@field stop fun(self: DuiApp): nil Detiene la aplicación
---@field test fun(self: DuiApp): string Función de prueba para la aplicación
---@field _opts DuiAppOpts Opciones de configuración
---@field _running boolean Indica si la aplicación está en ejecución
---@field _wm WindowManager Instancia del gestor de ventanas

---@class WindowOpts
---@field wintype WindowType Tipo de ventana para mostrar diagnósticos (línea o buffer)
---@field order WindowOrder Cómo agrupar diagnósticos
---@field orig_bufid number Número del buffer original desde donde se invocó la ventana
---@field orig_winid number Número de la ventana original desde donde se invocó la ventana
---@field bufid number Número del buffer de nuestra ventana
---@field winid number Número de la ventana de nuestra ventana

---@class Window
---@field new fun(self: Window, opts: WindowOpts?): Window Crea una nueva instancia de DuiWindow
---@field get_orig_bufid fun(self: Window): number Devuelve el buffer original
---@field get_orig_winid fun(self: Window): number Devuelve la ventana original
---@field get_bufid fun(self: Window): number Devuelve el buffer asociado a la ventana
---@field get_winid fun(self: Window): number Devuelve la ventana asociada
---@field get_wintype fun(self: Window): WindowType Devuelve el tipo de ventana
---@field get_order fun(self: Window): WindowOrder Devuelve el orden de agrupación
---@field _bufid number Número del buffer de nuestra ventana
---@field _winid number Número de la ventana de nuestra ventana
---@field _orig_bufid number Número del buffer original desde donde se invocó la ventana
---@field _orig_winid number Número de la ventana original desde donde se invocó la ventana
---@field _type WindowType Tipo de ventana para mostrar diagnósticos (línea o buffer)
---@field _order WindowOrder Cómo agrupar diagnósticos

---@class WindowManagerOpts

---@class WindowManager
---@field new fun(self: WindowManager, opts: WindowManagerOpts?): WindowManager Crea una nueva instancia de WindowManager
---@field is_running fun(self: WindowManager): boolean Devuelve true si el gestor de ventanas está en ejecución
---@field start fun(self: WindowManager): nil Inicia el gestor de ventanas
---@field stop fun(self: WindowManager): nil Detiene el gestor de ventanas
---@field clean fun(self: WindowManager): nil Limpia recursos asociados al gestor de ventanas
---@field is_registered fun(self: WindowManager, bufid: number): boolean Comprueba si una ventana está registrada para un buffer dado
---@field get_window fun(self: WindowManager, bufid: number): Window|nil Obtiene una ventana registrada para un buffer dado
---@field create_window fun(self: WindowManager, orig_winid: number, orig_bufid: number, type: WindowType, order: WindowOrder): Window Crea y registra una nueva ventana
---@field delete_window fun(self: WindowManager, bufid: number): nil Elimina una ventana registrada para un buffer dado
---@field _window_closed_handler fun(winid: number, bufid: number): nil Función manejadora para el cierre de ventanas
---@field _running boolean Indica si el gestor de ventanas está en ejecución

