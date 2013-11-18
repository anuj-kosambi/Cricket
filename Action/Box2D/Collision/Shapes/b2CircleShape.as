package Box2D.Collision.Shapes
{
    import Box2D.Collision.*;
    import Box2D.Common.*;
    import Box2D.Common.Math.*;

    public class b2CircleShape extends b2Shape
    {
        public var m_radius:Number;
        public var m_localPosition:b2Vec2;

        public function b2CircleShape(param1:b2ShapeDef)
        {
            var _loc_2:* = null;
            m_localPosition = new b2Vec2();
            super(param1);
            _loc_2 = param1 as b2CircleDef;
            m_type = e_circleShape;
            m_localPosition.SetV(_loc_2.localPosition);
            m_radius = _loc_2.radius;
            return;
        }// end function

        override public function TestPoint(param1:b2XForm, param2:b2Vec2) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_3 = param1.R;
            _loc_4 = param1.position.x + (_loc_3.col1.x * m_localPosition.x + _loc_3.col2.x * m_localPosition.y);
            _loc_5 = param1.position.y + (_loc_3.col1.y * m_localPosition.x + _loc_3.col2.y * m_localPosition.y);
            _loc_4 = param2.x - _loc_4;
            _loc_5 = param2.y - _loc_5;
            return _loc_4 * _loc_4 + _loc_5 * _loc_5 <= m_radius * m_radius;
        }// end function

        public function GetLocalPosition() : b2Vec2
        {
            return m_localPosition;
        }// end function

        override public function TestSegment(param1:b2XForm, param2:Array, param3:b2Vec2, param4:b2Segment, param5:Number) : Boolean
        {
            var _loc_6:* = null;
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
            _loc_6 = param1.R;
            _loc_7 = param1.position.x + (_loc_6.col1.x * m_localPosition.x + _loc_6.col2.x * m_localPosition.y);
            _loc_8 = param1.position.x + (_loc_6.col1.y * m_localPosition.x + _loc_6.col2.y * m_localPosition.y);
            _loc_9 = param4.p1.x - _loc_7;
            _loc_10 = param4.p1.y - _loc_8;
            _loc_11 = _loc_9 * _loc_9 + _loc_10 * _loc_10 - m_radius * m_radius;
            if (_loc_11 < 0)
            {
                return false;
            }
            _loc_12 = param4.p2.x - param4.p1.x;
            _loc_13 = param4.p2.y - param4.p1.y;
            _loc_14 = _loc_9 * _loc_12 + _loc_10 * _loc_13;
            _loc_15 = _loc_12 * _loc_12 + _loc_13 * _loc_13;
            _loc_16 = _loc_14 * _loc_14 - _loc_15 * _loc_11;
            if (_loc_16 < 0 || _loc_15 < Number.MIN_VALUE)
            {
                return false;
            }
            _loc_17 = -(_loc_14 + Math.sqrt(_loc_16));
            if (_loc_17 >= 0 && _loc_17 <= param5 * _loc_15)
            {
                _loc_17 = _loc_17 / _loc_15;
                param2[0] = _loc_17;
                param3.x = _loc_9 + _loc_17 * _loc_12;
                param3.y = _loc_10 + _loc_17 * _loc_13;
                param3.Normalize();
                return true;
            }
            return false;
        }// end function

        override public function ComputeMass(param1:b2MassData) : void
        {
            param1.mass = m_density * b2Settings.b2_pi * m_radius * m_radius;
            param1.center.SetV(m_localPosition);
            param1.I = param1.mass * (0.5 * m_radius * m_radius + (m_localPosition.x * m_localPosition.x + m_localPosition.y * m_localPosition.y));
            return;
        }// end function

        override public function ComputeSweptAABB(param1:b2AABB, param2:b2XForm, param3:b2XForm) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            _loc_4 = param2.R;
            _loc_5 = param2.position.x + (_loc_4.col1.x * m_localPosition.x + _loc_4.col2.x * m_localPosition.y);
            _loc_6 = param2.position.y + (_loc_4.col1.y * m_localPosition.x + _loc_4.col2.y * m_localPosition.y);
            _loc_4 = param3.R;
            _loc_7 = param3.position.x + (_loc_4.col1.x * m_localPosition.x + _loc_4.col2.x * m_localPosition.y);
            _loc_8 = param3.position.y + (_loc_4.col1.y * m_localPosition.x + _loc_4.col2.y * m_localPosition.y);
            param1.lowerBound.Set((_loc_5 < _loc_7 ? (_loc_5) : (_loc_7)) - m_radius, (_loc_6 < _loc_8 ? (_loc_6) : (_loc_8)) - m_radius);
            param1.upperBound.Set((_loc_5 > _loc_7 ? (_loc_5) : (_loc_7)) + m_radius, (_loc_6 > _loc_8 ? (_loc_6) : (_loc_8)) + m_radius);
            return;
        }// end function

        public function GetRadius() : Number
        {
            return m_radius;
        }// end function

        override public function UpdateSweepRadius(param1:b2Vec2) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            _loc_2 = m_localPosition.x - param1.x;
            _loc_3 = m_localPosition.y - param1.y;
            _loc_2 = Math.sqrt(_loc_2 * _loc_2 + _loc_3 * _loc_3);
            m_sweepRadius = _loc_2 + m_radius - b2Settings.b2_toiSlop;
            return;
        }// end function

        override public function ComputeAABB(param1:b2AABB, param2:b2XForm) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_5:* = NaN;
            _loc_3 = param2.R;
            _loc_4 = param2.position.x + (_loc_3.col1.x * m_localPosition.x + _loc_3.col2.x * m_localPosition.y);
            _loc_5 = param2.position.y + (_loc_3.col1.y * m_localPosition.x + _loc_3.col2.y * m_localPosition.y);
            param1.lowerBound.Set(_loc_4 - m_radius, _loc_5 - m_radius);
            param1.upperBound.Set(_loc_4 + m_radius, _loc_5 + m_radius);
            return;
        }// end function

    }
}
