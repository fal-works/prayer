package prayer.extensions;

#if macro
using prayer.extensions.MacroTypeMapper;

class ComplexTypeExtension {
	/**
		@return The return type of `complexType` if it is a function. otherwise `Failed`.
	**/
	public static function getReturnType(complexType: ComplexType): Maybe<ComplexType> {
		return switch complexType {
			case TFunction(_, returnType): Maybe.from(returnType);
			default: Maybe.none();
		}
	}

	/**
		Roughly checks unification of two `Expr.ComplexType` instances.
		Might not work in some cases as this first converts each type to `haxe.macro.Type`.
		@return `true` if `a` and `b` unify.
	**/
	public static function unifyComplex(a: ComplexType, b: ComplexType): Bool {
		return if (a == null)
			throw "a is null."
		else if (b == null)
			throw "b is null."
		else
			a.toType().unify(b.toType());
	}

	/**
		@return `true` if the given type is `null` or unifies `Void`.
	**/
	public static function isNullOrVoid(complexType: Null<ComplexType>): Bool
		return complexType == null || complexType.toType().unify(Values.voidType);

	/**
		Reveals the underlying type if `TNamed` (not recursively).
	**/
	public static function unwrapNamed(complexType: ComplexType): ComplexType {
		return switch complexType {
			case TNamed(_, underlyingType): underlyingType;
			default: complexType;
		}
	}

	/**
		Reveals the underlying type if `TNamed` (recursively).
	**/
	public static function unwrapNamedDeep(complexType: ComplexType): ComplexType
		return complexType.mapTypes(unwrapNamed);
}
#end
