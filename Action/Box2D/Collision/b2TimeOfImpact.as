package Box2D.Collision
{
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2TimeOfImpact extends Object
    {
        public static var s_xf1:b2XForm = new b2XForm();
        public static var s_xf2:b2XForm = new b2XForm();
        public static var s_p1:b2Vec2 = new b2Vec2();
        public static var s_p2:b2Vec2 = new b2Vec2();

        public function b2TimeOfImpact()
        {
            return;
        }// end function

        public static function TimeOfImpact(param1:b2Shape, param2:b2Sweep, param3:b2Shape, param4:b2Sweep) : Number
        {
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = NaN;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_23:* = NaN;
            var _loc_24:* = NaN;
            var _loc_25:* = NaN;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = NaN;
            var _loc_29:* = NaN;
            var _loc_30:* = NaN;
            var _loc_31:* = NaN;
            _loc_7 = param1.m_sweepRadius;
            _loc_8 = param3.m_sweepRadius;
            _loc_9 = param2.t0;
            _loc_10 = param2.c.x - param2.c0.x;
            _loc_11 = param2.c.y - param2.c0.y;
            _loc_12 = param4.c.x - param4.c0.x;
            _loc_13 = param4.c.y - param4.c0.y;
            _loc_14 = param2.a - param2.a0;
            _loc_15 = param4.a - param4.a0;
            _loc_16 = 0;
            _loc_17 = s_p1;
            _loc_18 = s_p2;
            _loc_19 = 20;
            _loc_20 = 0;
            _loc_21 = 0;
            _loc_22 = 0;
            _loc_23 = 0;
            _loc_24 = 0;
            while (true)
            {
                
                _loc_25 = (1 - _loc_16) * _loc_9 + _loc_16;
                _loc_26 = s_xf1;
                _loc_27 = s_xf2;
                param2.GetXForm(_loc_26, _loc_25);
                param4.GetXForm(_loc_27, _loc_25);
                _loc_23 = b2Distance.Distance(_loc_17, _loc_18, param1, _loc_26, param3, _loc_27);
                if (_loc_20 == 0)
                {
                    if (_loc_23 > 2 * b2Settings.b2_toiSlop)
                    {
                        _loc_24 = 1.5 * b2Settings.b2_toiSlop;
                    }
                    else
                    {
                        _loc_5 = 0.05 * b2Settings.b2_toiSlop;
                        _loc_6 = _loc_23 - 0.5 * b2Settings.b2_toiSlop;
                        _loc_24 = _loc_5 > _loc_6 ? (_loc_5) : (_loc_6);
                    }
                }
                if (_loc_23 - _loc_24 < 0.05 * b2Settings.b2_toiSlop || _loc_20 == _loc_19)
                {
                    break;
                }
                _loc_21 = _loc_18.x - _loc_17.x;
                _loc_22 = _loc_18.y - _loc_17.y;
                _loc_28 = Math.sqrt(_loc_21 * _loc_21 + _loc_22 * _loc_22);
                _loc_21 = _loc_21 / _loc_28;
                _loc_22 = _loc_22 / _loc_28;
                _loc_29 = _loc_21 * (_loc_10 - _loc_12) + _loc_22 * (_loc_11 - _loc_13) + (_loc_14 < 0 ? (-_loc_14) : (_loc_14)) * _loc_7 + (_loc_15 < 0 ? (-_loc_15) : (_loc_15)) * _loc_8;
                if (_loc_29 == 0)
                {
                    _loc_16 = 1;
                    break;
                }
                _loc_30 = (_loc_23 - _loc_24) / _loc_29;
                _loc_31 = _loc_16 + _loc_30;
                if (_loc_31 < 0 || _loc_31 > 1)
                {
                    _loc_16 = 1;
                    break;
                }
                if (_loc_31 < (1 + 100 * Number.MIN_VALUE) * _loc_16)
                {
                    break;
                }
                _loc_16 = _loc_31;
                _loc_20++;
            }
            return _loc_16;
        }// end function

    }
}
