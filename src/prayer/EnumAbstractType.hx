package prayer;

#if macro
/**
	A kind of `Type.AbstractType` instance that hs `@:enum` metadata.
**/
@:forward
abstract EnumAbstractType(AbstractType) to AbstractType {
	/**
		@param abstractType `Type.AbstractType`
		@return `EnumAbstractType` value, or an error message if `:enum` metadata is missing.
	**/
	public static function fromAbstractType(
		abstractType: AbstractType
	): MacroResult<EnumAbstractType> {
		return if (abstractType.meta.has(":enum"))
			Ok(new EnumAbstractType(abstractType))
		else
			Failed('Missing @:enum metadata', abstractType.pos);
	}

	/**
		Used internally in `getInstances()`.
	**/
	static function isEnumAbstractInstance(field: ClassField): Bool {
		final meta = field.meta;
		return meta.has(":enum") && meta.has(":impl");
	}

	/**
		@return The underlying `AbstractType` value.
	**/
	@:to public function toAbstractType(): AbstractType
		return this;

	/**
		@return `ComplexType` value converted from the underlying `haxe.macro.Type`.
	**/
	public function toComplexType(): ComplexType
		return this.type.toComplexType();

	/**
		@return `ComplexType` value converted using `TypeTools.toTypePath`.
	**/
	@:access(haxe.macro.TypeTools)
	public function toComplexType2(): ComplexType
		return TPath(this.toTypePath([]));

	/**
		@return Enum abstract instance fields of `type` as an array of `Type.ClassField`.
	**/
	public function getInstances(): Array<ClassField> {
		final implementation = this.impl;
		if (implementation == null) return [];

		final staticFields: Array<ClassField> = implementation.get().statics.get();

		return staticFields.filter(isEnumAbstractInstance);
	}

	function new(abstractType: AbstractType)
		this = abstractType;
}
#end
