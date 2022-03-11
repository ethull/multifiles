https://github.com/neoclide/coc.nvim/wiki/Language-servers#register-custom-language-servers

# java
    eclipse java lsp
        :CocInstall java
    georgewfraser/java-language-server    
        system setup
            cd ~/.vim/manual-setup/language-servers
            git clone https://github.com/georgewfraser/java-language-server.git     
            cd java-language-server
            scripts/link_linux.sh 
        integration
            coc-settings.json as custom lsp
# python 
    palantir/python-language-server
        :CocInstall python
        system setup
            pip3 install python-language-server
        integration
            coc-settings.json as provided lsp
# js, ts
    tsserver
        :CocInstall coc-tsserver
    javascript-typescript-langserver    
        system setup    
            npm i -g javascript-typescript-langserver
        integration
            coc-settings.json as custom lsp
    flow
        system setup
            TODO get setup
        integration
            coc-settings.json as provided lsp
    
# bash
    bash-language-server
        :CocInstall coc-sh 
        system setup
            npm i -g javascript-typescript-langserver
        integration
            coc-settings.json as provided lsp
# c
    ccls
        system setup
            TODO get setup    
            https://github.com/MaskRay/ccls/wiki
        integration
            coc-settings.json as provided lsp
    clangd
        system setup
            TODO get setup
            https://clang.llvm.org/docs/JSONCompilationDatabase.html
        integration    
            coc-settings.json as provided lsp

# php
    phpls
        https://github.com/bmewburn/intelephense-docs
        https://github.com/marlonfan/coc-phpls
        https://intelephense.com/
    phpactor
        https://github.com/phpactor/phpactor
    php-language-server
        https://github.com/felixfbecker/php-language-server
    serenata
        https://gitlab.com/Serenata/Serenata
        https://gitlab.com/Serenata/visual-studio-code-client
        https://gitlab.com/Serenata/Serenata/-/wikis/home
        https://github.com/ycm-core/lsp-examples/blob/master/php/snippet.vim
    phan
        https://github.com/phan/phan
    psalm
        https://github.com/vimeo/psalm
