package Box2D.Dynamics.Contacts
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;

    public class b2PolygonContact extends b2Contact
    {
        private var m_manifolds:Array;
        private var m0:b2Manifold;
        public var m_manifold:b2Manifold;
        private static const s_evalCP:b2ContactPoint = new b2ContactPoint();

        public function b2PolygonContact(param1:b2Shape, param2:b2Shape) : void
        {
            m0 = new b2Manifold();
            m_manifolds = [new b2Manifold()];
            super(param1, param2);
            m_manifold = m_manifolds[0];
            m_manifold.pointCount = 0;
            return;
        }// end function

        override public function GetManifolds() : Array
        {
            return m_manifolds;
        }// end function

        override public function Evaluate(param1:b2ContactListener) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            _loc_5 = m_shape1.m_body;
            _loc_6 = m_shape2.m_body;
            m0.Set(m_manifold);
            b2Collision.b2CollidePolygons(m_manifold, m_shape1 as b2PolygonShape, _loc_5.m_xf, m_shape2 as b2PolygonShape, _loc_6.m_xf);
            _loc_9 = [false, false];
            _loc_7 = s_evalCP;
            _loc_7.shape1 = m_shape1;
            _loc_7.shape2 = m_shape2;
            _loc_7.friction = m_friction;
            _loc_7.restitution = m_restitution;
            if (m_manifold.pointCount > 0)
            {
                _loc_8 = 0;
                while (_loc_8 < m_manifold.pointCount)
                {
                    
                    _loc_10 = m_manifold.points[_loc_8];
                    _loc_10.normalImpulse = 0;
                    _loc_10.tangentImpulse = 0;
                    _loc_11 = false;
                    _loc_12 = _loc_10.id._key;
                    _loc_13 = 0;
                    while (_loc_13 < m0.pointCount)
                    {
                        
                        if (_loc_9[_loc_13] == true)
                        {
                        }
                        else
                        {
                            _loc_4 = m0.points[_loc_13];
                            if (_loc_4.id._key == _loc_12)
                            {
                                _loc_9[_loc_13] = true;
                                _loc_10.normalImpulse = _loc_4.normalImpulse;
                                _loc_10.tangentImpulse = _loc_4.tangentImpulse;
                                _loc_11 = true;
                                if (param1 != null)
                                {
                                    _loc_7.position = _loc_5.GetWorldPoint(_loc_10.localPoint1);
                                    _loc_2 = _loc_5.GetLinearVelocityFromLocalPoint(_loc_10.localPoint1);
                                    _loc_3 = _loc_6.GetLinearVelocityFromLocalPoint(_loc_10.localPoint2);
                                    _loc_7.velocity.Set(_loc_3.x - _loc_2.x, _loc_3.y - _loc_2.y);
                                    _loc_7.normal.SetV(m_manifold.normal);
                                    _loc_7.separation = _loc_10.separation;
                                    _loc_7.id.key = _loc_12;
                                    param1.Persist(_loc_7);
                                }
                                break;
                            }
                        }
                        _loc_13++;
                    }
                    if (_loc_11 == false && param1 != null)
                    {
                        _loc_7.position = _loc_5.GetWorldPoint(_loc_10.localPoint1);
                        _loc_2 = _loc_5.GetLinearVelocityFromLocalPoint(_loc_10.localPoint1);
                        _loc_3 = _loc_6.GetLinearVelocityFromLocalPoint(_loc_10.localPoint2);
                        _loc_7.velocity.Set(_loc_3.x - _loc_2.x, _loc_3.y - _loc_2.y);
                        _loc_7.normal.SetV(m_manifold.normal);
                        _loc_7.separation = _loc_10.separation;
                        _loc_7.id.key = _loc_12;
                        param1.Add(_loc_7);
                    }
                    _loc_8++;
                }
                m_manifoldCount = 1;
            }
            else
            {
                m_manifoldCount = 0;
            }
            if (param1 == null)
            {
                return;
            }
            _loc_8 = 0;
            while (_loc_8 < m0.pointCount)
            {
                
                if (_loc_9[_loc_8])
                {
                }
                else
                {
                    _loc_4 = m0.points[_loc_8];
                    _loc_7.position = _loc_5.GetWorldPoint(_loc_4.localPoint1);
                    _loc_2 = _loc_5.GetLinearVelocityFromLocalPoint(_loc_4.localPoint1);
                    _loc_3 = _loc_6.GetLinearVelocityFromLocalPoint(_loc_4.localPoint2);
                    _loc_7.velocity.Set(_loc_3.x - _loc_2.x, _loc_3.y - _loc_2.y);
                    _loc_7.normal.SetV(m0.normal);
                    _loc_7.separation = _loc_4.separation;
                    _loc_7.id.key = _loc_4.id._key;
                    param1.Remove(_loc_7);
                }
                _loc_8++;
            }
            return;
        }// end function

        public static function Destroy(param1:b2Contact, param2) : void
        {
            return;
        }// end function

        public static function Create(param1:b2Shape, param2:b2Shape, param3) : b2Contact
        {
            return new b2PolygonContact(param1, param2);
        }// end function

    }
}
