package main

import (
    "dagger.io/dagger"
    "dagger.io/dagger/core"

    "universe.dagger.io/bash"
    "universe.dagger.io/docker"
)

dagger.#Plan & {
    client: filesystem: "reports": write: contents: actions.test.export.directories["/src/reports"]

    actions: {
        // ruby コンテナを利用するので Pull
        _dockerImage: core.#Pull & {source: "ruby:2"}

        // 作業ディレクトリパス定義
        _workDir: "/src"

        // ソースコードをコンテナへコピー
        _appSource: core.#Source & {
            path: "./"
        }
        setup: docker.#Copy & {
            input: docker.#Image & {
                rootfs: _dockerImage.output
            }
            contents: _appSource.output
            source: "./"
            dest: _workDir
        }

        // テスト実行
        test: bash.#Run & {
            input: setup.output
            workdir: _workDir
            script: {
                contents: #"""
                    bundle install
                    bundle exec rake test
                """#
            }
            export: {
                directories: "/src/reports": dagger.#FS
            }
        }
    }
}
