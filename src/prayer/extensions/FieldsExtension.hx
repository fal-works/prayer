package prayer.extensions;

#if macro
import prayer.Fields;
import prayer.Values;

class FieldsExtension {
	/**
		@return The first occurrence of field with `name`.
	**/
	public static function findByName(_this: Fields, name: String): Field {
		// TODO: use Maybe?
		var found = Values.nullField;

		final len = _this.length;
		var i = UInt.zero;
		var field: Field;
		while (i < len) {
			field = _this[i];
			if (field.name == name) {
				found = field;
				break;
			}
			++i;
		}

		return found;
	}

	/**
		Removes and returns the field `new`.
	**/
	public static function removeConstructor(_this: Fields): Field
		return _this.removeFirst(FieldExtension.isNew, Values.nullField);
}
#end
