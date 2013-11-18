package Box2D.Dynamics
{
    import Box2D.Collision.*;
    import Box2D.Collision.Shapes.*;
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.Contacts.*;

    public class b2ContactManager extends b2PairCallback
    {
        public var m_world:b2World;
        public var m_destroyImmediate:Boolean;
        public var m_nullContact:b2NullContact;
        private static const s_evalCP:b2ContactPoint = new b2ContactPoint();

        public function b2ContactManager()
        {
            m_nullContact = new b2NullContact();
            m_world = null;
            m_destroyImmediate = false;
            return;
        }// end function

        override public function PairAdded(param1, param2)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_3 = param1 as b2Shape;
            _loc_4 = param2 as b2Shape;
            _loc_5 = _loc_3.m_body;
            _loc_6 = _loc_4.m_body;
            if (_loc_5.IsStatic() && _loc_6.IsStatic())
            {
                return m_nullContact;
            }
            if (_loc_3.m_body == _loc_4.m_body)
            {
                return m_nullContact;
            }
            if (_loc_6.IsConnected(_loc_5))
            {
                return m_nullContact;
            }
            if (m_world.m_contactFilter != null && m_world.m_contactFilter.ShouldCollide(_loc_3, _loc_4) == false)
            {
                return m_nullContact;
            }
            _loc_7 = b2Contact.Create(_loc_3, _loc_4, m_world.m_blockAllocator);
            if (_loc_7 == null)
            {
                return m_nullContact;
            }
            _loc_3 = _loc_7.m_shape1;
            _loc_4 = _loc_7.m_shape2;
            _loc_5 = _loc_3.m_body;
            _loc_6 = _loc_4.m_body;
            _loc_7.m_prev = null;
            _loc_7.m_next = m_world.m_contactList;
            if (m_world.m_contactList != null)
            {
                m_world.m_contactList.m_prev = _loc_7;
            }
            m_world.m_contactList = _loc_7;
            _loc_7.m_node1.contact = _loc_7;
            _loc_7.m_node1.other = _loc_6;
            _loc_7.m_node1.prev = null;
            _loc_7.m_node1.next = _loc_5.m_contactList;
            if (_loc_5.m_contactList != null)
            {
                _loc_5.m_contactList.prev = _loc_7.m_node1;
            }
            _loc_5.m_contactList = _loc_7.m_node1;
            _loc_7.m_node2.contact = _loc_7;
            _loc_7.m_node2.other = _loc_5;
            _loc_7.m_node2.prev = null;
            _loc_7.m_node2.next = _loc_6.m_contactList;
            if (_loc_6.m_contactList != null)
            {
                _loc_6.m_contactList.prev = _loc_7.m_node2;
            }
            _loc_6.m_contactList = _loc_7.m_node2;
            var _loc_8:* = m_world;
            var _loc_9:* = _loc_8.m_contactCount + 1;
            _loc_8.m_contactCount = _loc_9;
            return _loc_7;
        }// end function

        override public function PairRemoved(param1, param2, param3) : void
        {
            var _loc_4:* = null;
            if (param3 == null)
            {
                return;
            }
            _loc_4 = param3 as b2Contact;
            if (_loc_4 == m_nullContact)
            {
                return;
            }
            Destroy(_loc_4);
            return;
        }// end function

        public function Destroy(param1:b2Contact) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            _loc_2 = param1.m_shape1;
            _loc_3 = param1.m_shape2;
            _loc_4 = param1.m_manifoldCount;
            if (_loc_4 > 0 && m_world.m_contactListener)
            {
                _loc_7 = _loc_2.m_body;
                _loc_8 = _loc_3.m_body;
                _loc_9 = param1.GetManifolds();
                _loc_10 = s_evalCP;
                _loc_10.shape1 = param1.m_shape1;
                _loc_10.shape2 = param1.m_shape1;
                _loc_10.friction = param1.m_friction;
                _loc_10.restitution = param1.m_restitution;
                _loc_11 = 0;
                while (_loc_11 < _loc_4)
                {
                    
                    _loc_12 = _loc_9[_loc_11];
                    _loc_10.normal.SetV(_loc_12.normal);
                    _loc_13 = 0;
                    while (_loc_13 < _loc_12.pointCount)
                    {
                        
                        _loc_14 = _loc_12.points[_loc_13];
                        _loc_10.position = _loc_7.GetWorldPoint(_loc_14.localPoint1);
                        _loc_15 = _loc_7.GetLinearVelocityFromLocalPoint(_loc_14.localPoint1);
                        _loc_16 = _loc_8.GetLinearVelocityFromLocalPoint(_loc_14.localPoint2);
                        _loc_10.velocity.Set(_loc_16.x - _loc_15.x, _loc_16.y - _loc_15.y);
                        _loc_10.separation = _loc_14.separation;
                        _loc_10.id.key = _loc_14.id._key;
                        m_world.m_contactListener.Remove(_loc_10);
                        _loc_13++;
                    }
                    _loc_11++;
                }
            }
            if (param1.m_prev)
            {
                param1.m_prev.m_next = param1.m_next;
            }
            if (param1.m_next)
            {
                param1.m_next.m_prev = param1.m_prev;
            }
            if (param1 == m_world.m_contactList)
            {
                m_world.m_contactList = param1.m_next;
            }
            _loc_5 = _loc_2.m_body;
            _loc_6 = _loc_3.m_body;
            if (param1.m_node1.prev)
            {
                param1.m_node1.prev.next = param1.m_node1.next;
            }
            if (param1.m_node1.next)
            {
                param1.m_node1.next.prev = param1.m_node1.prev;
            }
            if (param1.m_node1 == _loc_5.m_contactList)
            {
                _loc_5.m_contactList = param1.m_node1.next;
            }
            if (param1.m_node2.prev)
            {
                param1.m_node2.prev.next = param1.m_node2.next;
            }
            if (param1.m_node2.next)
            {
                param1.m_node2.next.prev = param1.m_node2.prev;
            }
            if (param1.m_node2 == _loc_6.m_contactList)
            {
                _loc_6.m_contactList = param1.m_node2.next;
            }
            b2Contact.Destroy(param1, m_world.m_blockAllocator);
            var _loc_17:* = m_world;
            var _loc_18:* = _loc_17.m_contactCount - 1;
            _loc_17.m_contactCount = _loc_18;
            return;
        }// end function

        public function Collide() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            _loc_1 = m_world.m_contactList;
            while (_loc_1)
            {
                
                _loc_2 = _loc_1.m_shape1.m_body;
                _loc_3 = _loc_1.m_shape2.m_body;
                if (_loc_2.IsSleeping() && _loc_3.IsSleeping())
                {
                }
                else
                {
                    _loc_1.Update(m_world.m_contactListener);
                }
                _loc_1 = _loc_1.m_next;
            }
            return;
        }// end function

    }
}
