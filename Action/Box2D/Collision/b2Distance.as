package Box2D.Collision
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2Distance extends Object
    {
        private static var s_p2s:Array = [new b2Vec2(), new b2Vec2(), new b2Vec2()];
        private static var s_p1s:Array = [new b2Vec2(), new b2Vec2(), new b2Vec2()];
        private static var s_points:Array = [new b2Vec2(), new b2Vec2(), new b2Vec2()];
        private static var gPoint:b2Point = new b2Point();
        public static var g_GJK_Iterations:int = 0;

        public function b2Distance()
        {
            return;
        }// end function

        public static function InPoints(param1:b2Vec2, param2:Array, param3:int) : Boolean
        {
            var _loc_4:* = NaN;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            _loc_4 = 100 * Number.MIN_VALUE;
            _loc_5 = 0;
            while (_loc_5 < param3)
            {
                
                _loc_6 = param2[_loc_5];
                _loc_7 = Math.abs(param1.x - _loc_6.x);
                _loc_8 = Math.abs(param1.y - _loc_6.y);
                _loc_9 = Math.max(Math.abs(param1.x), Math.abs(_loc_6.x));
                _loc_10 = Math.max(Math.abs(param1.y), Math.abs(_loc_6.y));
                if (_loc_7 < _loc_4 * (_loc_9 + 1) && _loc_8 < _loc_4 * (_loc_10 + 1))
                {
                    return true;
                }
                _loc_5++;
            }
            return false;
        }// end function

        public static function DistanceGeneric(param1:b2Vec2, param2:b2Vec2, param3, param4:b2XForm, param5, param6:b2XForm) : Number
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = 0;
            _loc_8 = s_p1s;
            _loc_9 = s_p2s;
            _loc_10 = s_points;
            _loc_11 = 0;
            param1.SetV(param3.GetFirstVertex(param4));
            param2.SetV(param5.GetFirstVertex(param6));
            _loc_12 = 0;
            _loc_13 = 20;
            _loc_14 = 0;
            while (_loc_14 < _loc_13)
            {
                
                _loc_15 = param2.x - param1.x;
                _loc_16 = param2.y - param1.y;
                _loc_17 = param3.Support(param4, _loc_15, _loc_16);
                _loc_18 = param5.Support(param6, -_loc_15, -_loc_16);
                _loc_12 = _loc_15 * _loc_15 + _loc_16 * _loc_16;
                _loc_19 = _loc_18.x - _loc_17.x;
                _loc_20 = _loc_18.y - _loc_17.y;
                _loc_21 = _loc_15 * _loc_19 + _loc_16 * _loc_20;
                if (_loc_12 - (_loc_15 * _loc_19 + _loc_16 * _loc_20) <= 0.01 * _loc_12)
                {
                    if (_loc_11 == 0)
                    {
                        param1.SetV(_loc_17);
                        param2.SetV(_loc_18);
                    }
                    g_GJK_Iterations = _loc_14;
                    return Math.sqrt(_loc_12);
                }
                switch(_loc_11)
                {
                    case 0:
                    {
                        _loc_7 = _loc_8[0];
                        _loc_7.SetV(_loc_17);
                        _loc_7 = _loc_9[0];
                        _loc_7.SetV(_loc_18);
                        _loc_7 = _loc_10[0];
                        _loc_7.x = _loc_19;
                        _loc_7.y = _loc_20;
                        param1.SetV(_loc_8[0]);
                        param2.SetV(_loc_9[0]);
                        _loc_11++;
                        break;
                    }
                    case 1:
                    {
                        _loc_7 = _loc_8[1];
                        _loc_7.SetV(_loc_17);
                        _loc_7 = _loc_9[1];
                        _loc_7.SetV(_loc_18);
                        _loc_7 = _loc_10[1];
                        _loc_7.x = _loc_19;
                        _loc_7.y = _loc_20;
                        _loc_11 = ProcessTwo(param1, param2, _loc_8, _loc_9, _loc_10);
                        break;
                    }
                    case 2:
                    {
                        _loc_7 = _loc_8[2];
                        _loc_7.SetV(_loc_17);
                        _loc_7 = _loc_9[2];
                        _loc_7.SetV(_loc_18);
                        _loc_7 = _loc_10[2];
                        _loc_7.x = _loc_19;
                        _loc_7.y = _loc_20;
                        _loc_11 = ProcessThree(param1, param2, _loc_8, _loc_9, _loc_10);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_11 == 3)
                {
                    g_GJK_Iterations = _loc_14;
                    return 0;
                }
                _loc_22 = -Number.MAX_VALUE;
                _loc_23 = 0;
                while (_loc_23 < _loc_11)
                {
                    
                    _loc_7 = _loc_10[_loc_23];
                    _loc_22 = b2Math.b2Max(_loc_22, _loc_7.x * _loc_7.x + _loc_7.y * _loc_7.y);
                    _loc_23++;
                }
                if (_loc_11 == 3 || _loc_12 <= 100 * Number.MIN_VALUE * _loc_22)
                {
                    g_GJK_Iterations = _loc_14;
                    _loc_15 = param2.x - param1.x;
                    _loc_16 = param2.y - param1.y;
                    _loc_12 = _loc_15 * _loc_15 + _loc_16 * _loc_16;
                    return Math.sqrt(_loc_12);
                }
                _loc_14++;
            }
            g_GJK_Iterations = _loc_13;
            return Math.sqrt(_loc_12);
        }// end function

        public static function DistanceCC(param1:b2Vec2, param2:b2Vec2, param3:b2CircleShape, param4:b2XForm, param5:b2CircleShape, param6:b2XForm) : Number
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            _loc_7 = param4.R;
            _loc_8 = param3.m_localPosition;
            _loc_9 = param4.position.x + (_loc_7.col1.x * _loc_8.x + _loc_7.col2.x * _loc_8.y);
            _loc_10 = param4.position.y + (_loc_7.col1.y * _loc_8.x + _loc_7.col2.y * _loc_8.y);
            _loc_7 = param6.R;
            _loc_8 = param5.m_localPosition;
            _loc_11 = param6.position.x + (_loc_7.col1.x * _loc_8.x + _loc_7.col2.x * _loc_8.y);
            _loc_12 = param6.position.y + (_loc_7.col1.y * _loc_8.x + _loc_7.col2.y * _loc_8.y);
            _loc_13 = _loc_11 - _loc_9;
            _loc_14 = _loc_12 - _loc_10;
            _loc_15 = _loc_13 * _loc_13 + _loc_14 * _loc_14;
            _loc_16 = param3.m_radius - b2Settings.b2_toiSlop;
            _loc_17 = param5.m_radius - b2Settings.b2_toiSlop;
            _loc_18 = _loc_16 + _loc_17;
            if (_loc_15 > _loc_18 * _loc_18)
            {
                _loc_19 = Math.sqrt(_loc_13 * _loc_13 + _loc_14 * _loc_14);
                _loc_13 = _loc_13 / _loc_19;
                _loc_14 = _loc_14 / _loc_19;
                _loc_20 = _loc_19 - _loc_18;
                param1.x = _loc_9 + _loc_16 * _loc_13;
                param1.y = _loc_10 + _loc_16 * _loc_14;
                param2.x = _loc_11 - _loc_17 * _loc_13;
                param2.y = _loc_12 - _loc_17 * _loc_14;
                return _loc_20;
            }
            if (_loc_15 > Number.MIN_VALUE * Number.MIN_VALUE)
            {
                _loc_19 = Math.sqrt(_loc_13 * _loc_13 + _loc_14 * _loc_14);
                _loc_13 = _loc_13 / _loc_19;
                _loc_14 = _loc_14 / _loc_19;
                param1.x = _loc_9 + _loc_16 * _loc_13;
                param1.y = _loc_10 + _loc_16 * _loc_14;
                param2.x = param1.x;
                param2.y = param1.y;
                return 0;
            }
            param1.x = _loc_9;
            param1.y = _loc_10;
            param2.x = param1.x;
            param2.y = param1.y;
            return 0;
        }// end function

        public static function ProcessThree(param1:b2Vec2, param2:b2Vec2, param3:Array, param4:Array, param5:Array) : int
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = NaN;
            var _loc_27:* = NaN;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            var _loc_32:* = NaN;
            var _loc_33:* = NaN;
            var _loc_34:* = NaN;
            var _loc_35:* = NaN;
            var _loc_36:* = NaN;
            var _loc_37:* = NaN;
            var _loc_38:* = NaN;
            var _loc_39:* = NaN;
            var _loc_40:* = NaN;
            var _loc_41:* = NaN;
            _loc_6 = param5[0];
            _loc_7 = param5[1];
            _loc_8 = param5[2];
            _loc_9 = param3[0];
            _loc_10 = param3[1];
            _loc_11 = param3[2];
            _loc_12 = param4[0];
            _loc_13 = param4[1];
            _loc_14 = param4[2];
            _loc_15 = _loc_6.x;
            _loc_16 = _loc_6.y;
            _loc_17 = _loc_7.x;
            _loc_18 = _loc_7.y;
            _loc_19 = _loc_8.x;
            _loc_20 = _loc_8.y;
            _loc_21 = _loc_17 - _loc_15;
            _loc_22 = _loc_18 - _loc_16;
            _loc_23 = _loc_19 - _loc_15;
            _loc_24 = _loc_20 - _loc_16;
            _loc_25 = _loc_19 - _loc_17;
            _loc_26 = _loc_20 - _loc_18;
            _loc_27 = -(_loc_15 * _loc_21 + _loc_16 * _loc_22);
            _loc_28 = _loc_17 * _loc_21 + _loc_18 * _loc_22;
            _loc_29 = -(_loc_15 * _loc_23 + _loc_16 * _loc_24);
            _loc_30 = _loc_19 * _loc_23 + _loc_20 * _loc_24;
            _loc_31 = -(_loc_17 * _loc_25 + _loc_18 * _loc_26);
            _loc_32 = _loc_19 * _loc_25 + _loc_20 * _loc_26;
            if (_loc_30 <= 0 && _loc_32 <= 0)
            {
                param1.SetV(_loc_11);
                param2.SetV(_loc_14);
                _loc_9.SetV(_loc_11);
                _loc_12.SetV(_loc_14);
                _loc_6.SetV(_loc_8);
                return 1;
            }
            _loc_33 = _loc_21 * _loc_24 - _loc_22 * _loc_23;
            _loc_34 = _loc_33 * (_loc_15 * _loc_18 - _loc_16 * _loc_17);
            _loc_36 = _loc_33 * (_loc_17 * _loc_20 - _loc_18 * _loc_19);
            if (_loc_36 <= 0 && _loc_31 >= 0 && _loc_32 >= 0 && _loc_31 + _loc_32 > 0)
            {
                _loc_35 = _loc_31 / (_loc_31 + _loc_32);
                param1.x = _loc_10.x + _loc_35 * (_loc_11.x - _loc_10.x);
                param1.y = _loc_10.y + _loc_35 * (_loc_11.y - _loc_10.y);
                param2.x = _loc_13.x + _loc_35 * (_loc_14.x - _loc_13.x);
                param2.y = _loc_13.y + _loc_35 * (_loc_14.y - _loc_13.y);
                _loc_9.SetV(_loc_11);
                _loc_12.SetV(_loc_14);
                _loc_6.SetV(_loc_8);
                return 2;
            }
            _loc_37 = _loc_33 * (_loc_19 * _loc_16 - _loc_20 * _loc_15);
            if (_loc_37 <= 0 && _loc_29 >= 0 && _loc_30 >= 0 && _loc_29 + _loc_30 > 0)
            {
                _loc_35 = _loc_29 / (_loc_29 + _loc_30);
                param1.x = _loc_9.x + _loc_35 * (_loc_11.x - _loc_9.x);
                param1.y = _loc_9.y + _loc_35 * (_loc_11.y - _loc_9.y);
                param2.x = _loc_12.x + _loc_35 * (_loc_14.x - _loc_12.x);
                param2.y = _loc_12.y + _loc_35 * (_loc_14.y - _loc_12.y);
                _loc_10.SetV(_loc_11);
                _loc_13.SetV(_loc_14);
                _loc_7.SetV(_loc_8);
                return 2;
            }
            _loc_38 = _loc_36 + _loc_37 + _loc_34;
            _loc_38 = 1 / _loc_38;
            _loc_39 = _loc_36 * _loc_38;
            _loc_40 = _loc_37 * _loc_38;
            _loc_41 = 1 - _loc_39 - _loc_40;
            param1.x = _loc_39 * _loc_9.x + _loc_40 * _loc_10.x + _loc_41 * _loc_11.x;
            param1.y = _loc_39 * _loc_9.y + _loc_40 * _loc_10.y + _loc_41 * _loc_11.y;
            param2.x = _loc_39 * _loc_12.x + _loc_40 * _loc_13.x + _loc_41 * _loc_14.x;
            param2.y = _loc_39 * _loc_12.y + _loc_40 * _loc_13.y + _loc_41 * _loc_14.y;
            return 3;
        }// end function

        public static function DistancePC(param1:b2Vec2, param2:b2Vec2, param3:b2PolygonShape, param4:b2XForm, param5:b2CircleShape, param6:b2XForm) : Number
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            _loc_9 = gPoint;
            _loc_8 = param5.m_localPosition;
            _loc_7 = param6.R;
            _loc_9.p.x = param6.position.x + (_loc_7.col1.x * _loc_8.x + _loc_7.col2.x * _loc_8.y);
            _loc_9.p.y = param6.position.y + (_loc_7.col1.y * _loc_8.x + _loc_7.col2.y * _loc_8.y);
            _loc_10 = DistanceGeneric(param1, param2, param3, param4, _loc_9, b2Math.b2XForm_identity);
            _loc_11 = param5.m_radius - b2Settings.b2_toiSlop;
            if (_loc_10 > _loc_11)
            {
                _loc_10 = _loc_10 - _loc_11;
                _loc_12 = param2.x - param1.x;
                _loc_13 = param2.y - param1.y;
                _loc_14 = Math.sqrt(_loc_12 * _loc_12 + _loc_13 * _loc_13);
                _loc_12 = _loc_12 / _loc_14;
                _loc_13 = _loc_13 / _loc_14;
                param2.x = param2.x - _loc_11 * _loc_12;
                param2.y = param2.y - _loc_11 * _loc_13;
            }
            else
            {
                _loc_10 = 0;
                param2.x = param1.x;
                param2.y = param1.y;
            }
            return _loc_10;
        }// end function

        public static function Distance(param1:b2Vec2, param2:b2Vec2, param3:b2Shape, param4:b2XForm, param5:b2Shape, param6:b2XForm) : Number
        {
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            _loc_7 = param3.m_type;
            _loc_8 = param5.m_type;
            if (_loc_7 == b2Shape.e_circleShape && _loc_8 == b2Shape.e_circleShape)
            {
                return DistanceCC(param1, param2, param3 as b2CircleShape, param4, param5 as b2CircleShape, param6);
            }
            if (_loc_7 == b2Shape.e_polygonShape && _loc_8 == b2Shape.e_circleShape)
            {
                return DistancePC(param1, param2, param3 as b2PolygonShape, param4, param5 as b2CircleShape, param6);
            }
            if (_loc_7 == b2Shape.e_circleShape && _loc_8 == b2Shape.e_polygonShape)
            {
                return DistancePC(param2, param1, param5 as b2PolygonShape, param6, param3 as b2CircleShape, param4);
            }
            if (_loc_7 == b2Shape.e_polygonShape && _loc_8 == b2Shape.e_polygonShape)
            {
                return DistanceGeneric(param1, param2, param3 as b2PolygonShape, param4, param5 as b2PolygonShape, param6);
            }
            return 0;
        }// end function

        public static function ProcessTwo(param1:b2Vec2, param2:b2Vec2, param3:Array, param4:Array, param5:Array) : int
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            _loc_6 = param5[0];
            _loc_7 = param5[1];
            _loc_8 = param3[0];
            _loc_9 = param3[1];
            _loc_10 = param4[0];
            _loc_11 = param4[1];
            _loc_12 = -_loc_7.x;
            _loc_13 = -_loc_7.y;
            _loc_14 = _loc_6.x - _loc_7.x;
            _loc_15 = _loc_6.y - _loc_7.y;
            _loc_16 = Math.sqrt(_loc_14 * _loc_14 + _loc_15 * _loc_15);
            _loc_14 = _loc_14 / _loc_16;
            _loc_15 = _loc_15 / _loc_16;
            _loc_17 = _loc_12 * _loc_14 + _loc_13 * _loc_15;
            if (_loc_17 <= 0 || _loc_16 < Number.MIN_VALUE)
            {
                param1.SetV(_loc_9);
                param2.SetV(_loc_11);
                _loc_8.SetV(_loc_9);
                _loc_10.SetV(_loc_11);
                _loc_6.SetV(_loc_7);
                return 1;
            }
            _loc_17 = _loc_17 / _loc_16;
            param1.x = _loc_9.x + _loc_17 * (_loc_8.x - _loc_9.x);
            param1.y = _loc_9.y + _loc_17 * (_loc_8.y - _loc_9.y);
            param2.x = _loc_11.x + _loc_17 * (_loc_10.x - _loc_11.x);
            param2.y = _loc_11.y + _loc_17 * (_loc_10.y - _loc_11.y);
            return 2;
        }// end function

    }
}
