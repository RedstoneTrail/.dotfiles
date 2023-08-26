return {
	["rust-analyzer"] = {
		checkOnSave = {
			command = "clippy"
		},
		completions = {
			snippets = {
				custom = {
					["Arc::new"] = {
						postfix = "arc",
						body = "Arc::new(${receiver})",
						requires = "std::sync::Arc",
						description = "Put the expression into an `Arc`",
						scope = "expr"
					},
					["Rc::new"] = {
						postfix = "rc",
						body = "Rc::new(${receiver})",
						requires = "std::rc::Rc",
						description = "Put the expression into an `Rc`",
						scope = "expr"
					},
					["Box::pin"] = {
						postfix = "pinbox",
						body = "Box::pin(${receiver})",
						requires = "std::boxed::Box",
						description = "Put the expression into a pinned `Box`",
						scope = "expr"
					},
					Ok = {
						postfix = "ok",
						body = "Ok(${receiver})",
						description = "Wrap the expression in a `Result::Ok`",
						scope = "expr"
					},
					Err = {
						postfix = "err",
						body = "Err(${receiver})",
						description = "Wrap the expression in a `Result::Err`",
						scope = "expr"
					},
					Some = {
						postfix = "some",
						body = "Some(${receiver})",
						description = "Wrap the expression in an `Option::Some`",
						scope = "expr"
					}
				}
			}
		}
	}
}
