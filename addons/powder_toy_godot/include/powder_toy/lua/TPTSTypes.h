#pragma once
#include "common/PTString.h"
#include "gui/interface/Point.h"
#include <variant>

enum ValueType { TypeNumber, TypeFloat, TypePoint, TypeString, TypeNull, TypeFunction };
typedef std::variant<int, float, PTString, ui::Point> ValueValue;

class GeneralException
{
protected:
	PTString exception;
public:
	GeneralException(PTString message){
		exception = message;
	}
	PTString GetExceptionMessage() {
		return exception;
	}
};


class NumberType;
class FloatType;
class StringType;
class PointType;

class AnyType
{
protected:
	ValueType type;
	ValueValue value;
public:
	AnyType(ValueType type_, ValueValue value_);
	operator NumberType();
	operator FloatType();
	operator StringType();
	operator PointType();
	ValueType GetType();
	ByteString TypeName()
	{
		switch(type)
		{
		case TypeNumber:
			return "Number";
		case TypeFloat:
			return "Float";
		case TypePoint:
			return "Point";
		case TypeString:
			return "PTString";
		case TypeNull:
			return "Null";
		case TypeFunction:
			return "Function";
		default:
			return "Unknown";
		}
	}
	static ByteString TypeName(ValueType type)
	{
		switch(type)
		{
		case TypeNumber:
			return "Number";
		case TypeFloat:
			return "Float";
		case TypePoint:
			return "Point";
		case TypeString:
			return "PTString";
		case TypeNull:
			return "Null";
		case TypeFunction:
			return "Function";
		default:
			return "Unknown";
		}
	}
};

class InvalidConversionException: public GeneralException
{
public:
	InvalidConversionException(ValueType from_, ValueType to_):
	GeneralException("Invalid conversion from " + AnyType::TypeName(from_).FromAscii() + " to " + AnyType::TypeName(to_).FromAscii()) {
	}
};

class NumberType: public AnyType
{
public:
	NumberType(int number);
	int Value();
};

class FloatType: public AnyType
{
public:
	FloatType(float number);
	float Value();
};

class StringType: public AnyType
{
public:
	StringType(PTString string);
	PTString Value();
};

class PointType: public AnyType
{
public:
	PointType(ui::Point point);
	PointType(int pointX, int pointY);
	ui::Point Value();
};
