package prayer;

#if macro
/**
	Type that represents either success (`Ok`) or failure (`Failed`).
**/
@:using(prayer.MacroResult.MacroResultExtension)
enum MacroResult<T> {
	Ok(value: T);
	Failed(message: String, position: Position);
}

class MacroResultExtension {
	/**
		@return `true` if `this` is `Ok`.
	**/
	public static function isOk<T>(_this: MacroResult<T>): Bool {
		return switch _this {
			case Ok(_): true;
			case Failed(_, _): false;
		}
	}

	/**
		@return `true` if `this` is `Failed`.
	**/
	public static function isFailed<T>(_this: MacroResult<T>): Bool
		return !isOk(_this);

	/**
		@return The value if `Ok`. If `Failed`, outputs error and aborts the current macro call.
	**/
	public static function unwrap<T>(_this: MacroResult<T>): T {
		return switch _this {
			case Ok(value): value;
			case Failed(value, position):
				Context.error(value, position);
				throw value;
		}
	}

	/**
		Casts `this` to `Maybe<T>`.
		Failure information is dropped if `this` is `Failed`.
	**/
	public static function toMaybe<T>(_this: MacroResult<T>): Maybe<T> {
		return switch _this {
			case Ok(value): Maybe.from(value);
			case Failed(_, _): Maybe.none();
		}
	}
}
#end
