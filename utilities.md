# panvimdoc (pruebas)

Lo usamos para generar la documentación en formato vim para ver como queda antes de hacer un push y que se ejecute el workflow.
```sh
panvimdoc --project-name lua-dui --input-file README.md --vim-version "Neovim >= 0.8.0" --toc true --description "" --dedup-subheadings true --demojify true --treesitter true --ignore-rawblocks true --doc-mapping false --doc-mapping-project-name true --shift-heading-level-by 0 --increment-heading-level-by 0
```
