package Box2D.Collision
{
    import Box2D.Common.Math.*;

    public class b2Segment extends Object
    {
        public var p1:b2Vec2;
        public var p2:b2Vec2;

        public function b2Segment()
        {
            p1 = new b2Vec2();
            p2 = new b2Vec2();
            return;
        }// end function

        public function TestSegment(param1:Array, param2:b2Vec2, param3:b2Segment, param4:Number) : Boolean
        {
            var _loc_5:* = null;
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
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            _loc_5 = param3.p1;
            _loc_6 = param3.p2.x - _loc_5.x;
            _loc_7 = param3.p2.y - _loc_5.y;
            _loc_8 = p2.x - p1.x;
            _loc_9 = p2.y - p1.y;
            _loc_10 = _loc_9;
            _loc_11 = -_loc_8;
            _loc_12 = 100 * Number.MIN_VALUE;
            _loc_13 = -(_loc_6 * _loc_10 + _loc_7 * _loc_11);
            if (_loc_13 > _loc_12)
            {
                _loc_14 = _loc_5.x - p1.x;
                _loc_15 = _loc_5.y - p1.y;
                _loc_16 = _loc_14 * _loc_10 + _loc_15 * _loc_11;
                if (_loc_16 >= 0 && _loc_16 <= param4 * _loc_13)
                {
                    _loc_17 = (-_loc_7) * _loc_15 + _loc_7 * _loc_14;
                    if ((-_loc_12) * _loc_13 <= _loc_17 && _loc_17 <= _loc_13 * (1 + _loc_12))
                    {
                        _loc_16 = _loc_16 / _loc_13;
                        _loc_18 = Math.sqrt(_loc_10 * _loc_10 + _loc_11 * _loc_11);
                        _loc_10 = _loc_10 / _loc_18;
                        _loc_11 = _loc_11 / _loc_18;
                        param1[0] = _loc_16;
                        param2.Set(_loc_10, _loc_11);
                        return true;
                    }
                }
            }
            return false;
        }// end function

    }
}
