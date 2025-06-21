代码	说明
storage/unknown	发生未知错误。
storage/object-not-found	指定的引用中没有任何对象。
storage/bucket-not-found	没有为 Cloud Storage 配置任何存储桶。
storage/project-not-found	没有为 Cloud Storage 配置任何项目。
storage/quota-exceeded	已超过您的 Cloud Storage 存储桶的配额。如果您使用的是 Spark 定价方案，不妨考虑升级到随用随付 Blaze 定价方案。如果您已采用 Blaze 定价方案，请与 Firebase 支持团队联系。

重要提示：自 2025 年 10 月 1 日起，必须采用 Blaze 定价方案才能使用 Cloud Storage，即使是默认存储桶也是如此。
storage/unauthenticated	用户未经过身份验证，请先进行身份验证，然后重试。
storage/unauthorized	用户无权执行所需的操作，请检查您的安全规则以确保其正确无误。
storage/retry-limit-exceeded	已超出某项操作（上传、下载、删除等）的最长时间限制。请尝试重新上传。
storage/invalid-checksum	客户端上的文件与服务器收到的文件的校验和不匹配。请尝试重新上传。
storage/canceled	用户已取消操作。
storage/invalid-event-name	提供的事件名称无效。必须是以下各项之一：running、progress、pause。
storage/invalid-url	提供给 refFromURL() 的网址无效。必须采用 gs://bucket/object 或 https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN> 格式。
storage/invalid-argument	传递给 put() 的参数必须是 File、Blob 或 UInt8 数组。传递给 putString() 的参数必须是原始字符串、Base64 或 Base64URL 字符串。
storage/no-default-bucket	您的配置的 storageBucket 属性中未设置任何存储桶。
storage/cannot-slice-blob	通常在本地文件发生更改（已删除、已再次保存等）时出现。请在验证文件未发生更改后尝试重新上传。
storage/server-file-wrong-size	客户端上的文件与服务器收到的文件的大小不匹配。请尝试重新上传。