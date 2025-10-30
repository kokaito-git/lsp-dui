# panvimdoc (pruebas)

Lo usamos para generar la documentación en formato vim para ver como queda antes de hacer un push y que se ejecute el workflow.
```sh
panvimdoc --project-name lsp-dui --input-file README.md --vim-version "Neovim >= 0.8.0" --toc true --description "" --dedup-subheadings true --demojify true --treesitter true --ignore-rawblocks true --doc-mapping false --doc-mapping-project-name true --shift-heading-level-by -1 --increment-heading-level-by 0; cat doc/lsp-dui.txt
```

# stylua

`sudo pacman -S stylua`

Probar el linter antes de hacer commit:

```sh
stylua --check lua
```

# Luarocks

Se ejecuta release.yml cuando haces un push con un tag vX.Y.Z y este release sube el paquete a luarocks.org

Para hacer un release manualmente:

```sh
git tag v0.0.1
git push v0.0.1
```
