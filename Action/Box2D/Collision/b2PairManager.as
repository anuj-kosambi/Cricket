package Box2D.Collision
{
    import Box2D.Common.*;

    public class b2PairManager extends Object
    {
        public var m_pairCount:int;
        public var m_pairBuffer:Array;
        public var m_callback:b2PairCallback;
        public var m_pairs:Array;
        public var m_pairBufferCount:int;
        public var m_hashTable:Array;
        public var m_broadPhase:b2BroadPhase;
        public var m_freePair:uint;

        public function b2PairManager()
        {
            var _loc_1:* = 0;
            m_hashTable = new Array(b2Pair.b2_tableCapacity);
            _loc_1 = 0;
            while (_loc_1 < b2Pair.b2_tableCapacity)
            {
                
                m_hashTable[_loc_1] = b2Pair.b2_nullPair;
                _loc_1 = _loc_1 + 1;
            }
            m_pairs = new Array(b2Settings.b2_maxPairs);
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxPairs)
            {
                
                m_pairs[_loc_1] = new b2Pair();
                _loc_1 = _loc_1 + 1;
            }
            m_pairBuffer = new Array(b2Settings.b2_maxPairs);
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxPairs)
            {
                
                m_pairBuffer[_loc_1] = new b2BufferedPair();
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < b2Settings.b2_maxPairs)
            {
                
                m_pairs[_loc_1].proxyId1 = b2Pair.b2_nullProxy;
                m_pairs[_loc_1].proxyId2 = b2Pair.b2_nullProxy;
                m_pairs[_loc_1].userData = null;
                m_pairs[_loc_1].status = 0;
                m_pairs[_loc_1].next = _loc_1 + 1;
                _loc_1 = _loc_1 + 1;
            }
            m_pairs[int((b2Settings.b2_maxPairs - 1))].next = b2Pair.b2_nullPair;
            m_pairCount = 0;
            m_pairBufferCount = 0;
            return;
        }// end function

        private function FindHash(param1:uint, param2:uint, param3:uint) : b2Pair
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            _loc_5 = m_hashTable[param3];
            _loc_4 = m_pairs[_loc_5];
            while (_loc_5 != b2Pair.b2_nullPair && Equals(_loc_4, param1, param2) == false)
            {
                
                _loc_5 = _loc_4.next;
                _loc_4 = m_pairs[_loc_5];
            }
            if (_loc_5 == b2Pair.b2_nullPair)
            {
                return null;
            }
            return _loc_4;
        }// end function

        private function Find(param1:uint, param2:uint) : b2Pair
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            if (param1 > param2)
            {
                _loc_4 = param1;
                param1 = param2;
                param2 = _loc_4;
            }
            _loc_3 = Hash(param1, param2) & b2Pair.b2_tableMask;
            return FindHash(param1, param2, _loc_3);
        }// end function

        private function ValidateBuffer() : void
        {
            return;
        }// end function

        public function Commit() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_3 = 0;
            _loc_4 = m_broadPhase.m_proxyPool;
            _loc_2 = 0;
            while (_loc_2 < m_pairBufferCount)
            {
                
                _loc_1 = m_pairBuffer[_loc_2];
                _loc_5 = Find(_loc_1.proxyId1, _loc_1.proxyId2);
                _loc_5.ClearBuffered();
                _loc_6 = _loc_4[_loc_5.proxyId1];
                _loc_7 = _loc_4[_loc_5.proxyId2];
                if (_loc_5.IsRemoved())
                {
                    if (_loc_5.IsFinal() == true)
                    {
                        m_callback.PairRemoved(_loc_6.userData, _loc_7.userData, _loc_5.userData);
                    }
                    _loc_1 = m_pairBuffer[_loc_3];
                    _loc_1.proxyId1 = _loc_5.proxyId1;
                    _loc_1.proxyId2 = _loc_5.proxyId2;
                    _loc_3++;
                }
                else if (_loc_5.IsFinal() == false)
                {
                    _loc_5.userData = m_callback.PairAdded(_loc_6.userData, _loc_7.userData);
                    _loc_5.SetFinal();
                }
                _loc_2++;
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                _loc_1 = m_pairBuffer[_loc_2];
                RemovePair(_loc_1.proxyId1, _loc_1.proxyId2);
                _loc_2++;
            }
            m_pairBufferCount = 0;
            if (b2BroadPhase.s_validate)
            {
                ValidateTable();
            }
            return;
        }// end function

        public function RemoveBufferedPair(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_4 = Find(param1, param2);
            if (_loc_4 == null)
            {
                return;
            }
            if (_loc_4.IsBuffered() == false)
            {
                _loc_4.SetBuffered();
                _loc_3 = m_pairBuffer[m_pairBufferCount];
                _loc_3.proxyId1 = _loc_4.proxyId1;
                _loc_3.proxyId2 = _loc_4.proxyId2;
                var _loc_6:* = m_pairBufferCount + 1;
                m_pairBufferCount = _loc_6;
            }
            _loc_4.SetRemoved();
            if (b2BroadPhase.s_validate)
            {
                ValidateBuffer();
            }
            return;
        }// end function

        private function RemovePair(param1:uint, param2:uint)
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = undefined;
            if (param1 > param2)
            {
                _loc_7 = param1;
                param1 = param2;
                param2 = _loc_7;
            }
            _loc_4 = Hash(param1, param2) & b2Pair.b2_tableMask;
            _loc_5 = m_hashTable[_loc_4];
            _loc_6 = null;
            while (_loc_5 != b2Pair.b2_nullPair)
            {
                
                if (Equals(m_pairs[_loc_5], param1, param2))
                {
                    _loc_8 = _loc_5;
                    _loc_3 = m_pairs[_loc_5];
                    if (_loc_6)
                    {
                        _loc_6.next = _loc_3.next;
                    }
                    else
                    {
                        m_hashTable[_loc_4] = _loc_3.next;
                    }
                    _loc_3 = m_pairs[_loc_8];
                    _loc_9 = _loc_3.userData;
                    _loc_3.next = m_freePair;
                    _loc_3.proxyId1 = b2Pair.b2_nullProxy;
                    _loc_3.proxyId2 = b2Pair.b2_nullProxy;
                    _loc_3.userData = null;
                    _loc_3.status = 0;
                    m_freePair = _loc_8;
                    var _loc_11:* = m_pairCount - 1;
                    m_pairCount = _loc_11;
                    return _loc_9;
                    continue;
                }
                _loc_6 = m_pairs[_loc_5];
                _loc_5 = _loc_6.next;
            }
            return null;
        }// end function

        public function Initialize(param1:b2BroadPhase, param2:b2PairCallback) : void
        {
            m_broadPhase = param1;
            m_callback = param2;
            return;
        }// end function

        public function AddBufferedPair(param1:int, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_4 = AddPair(param1, param2);
            if (_loc_4.IsBuffered() == false)
            {
                _loc_4.SetBuffered();
                _loc_3 = m_pairBuffer[m_pairBufferCount];
                _loc_3.proxyId1 = _loc_4.proxyId1;
                _loc_3.proxyId2 = _loc_4.proxyId2;
                var _loc_6:* = m_pairBufferCount + 1;
                m_pairBufferCount = _loc_6;
            }
            _loc_4.ClearRemoved();
            if (b2BroadPhase.s_validate)
            {
                ValidateBuffer();
            }
            return;
        }// end function

        private function AddPair(param1:uint, param2:uint) : b2Pair
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1 > param2)
            {
                _loc_6 = param1;
                param1 = param2;
                param2 = _loc_6;
            }
            _loc_3 = Hash(param1, param2) & b2Pair.b2_tableMask;
            var _loc_7:* = FindHash(param1, param2, _loc_3);
            _loc_4 = FindHash(param1, param2, _loc_3);
            _loc_4 = _loc_7;
            if (_loc_4 != null)
            {
                return _loc_4;
            }
            _loc_5 = m_freePair;
            _loc_4 = m_pairs[_loc_5];
            m_freePair = _loc_4.next;
            _loc_4.proxyId1 = param1;
            _loc_4.proxyId2 = param2;
            _loc_4.status = 0;
            _loc_4.userData = null;
            _loc_4.next = m_hashTable[_loc_3];
            m_hashTable[_loc_3] = _loc_5;
            var _loc_8:* = m_pairCount + 1;
            m_pairCount = _loc_8;
            return _loc_4;
        }// end function

        private function ValidateTable() : void
        {
            return;
        }// end function

        public static function EqualsPair(param1:b2BufferedPair, param2:b2BufferedPair) : Boolean
        {
            return param1.proxyId1 == param2.proxyId1 && param1.proxyId2 == param2.proxyId2;
        }// end function

        public static function Hash(param1:uint, param2:uint) : uint
        {
            var _loc_3:* = 0;
            _loc_3 = param2 << 16 & 4294901760 | param1;
            _loc_3 = ~_loc_3 + (_loc_3 << 15 & 4294934528);
            _loc_3 = _loc_3 ^ _loc_3 >> 12 & 1048575;
            _loc_3 = _loc_3 + (_loc_3 << 2 & 4294967292);
            _loc_3 = _loc_3 ^ _loc_3 >> 4 & 268435455;
            _loc_3 = _loc_3 * 2057;
            _loc_3 = _loc_3 ^ _loc_3 >> 16 & 65535;
            return _loc_3;
        }// end function

        public static function Equals(param1:b2Pair, param2:uint, param3:uint) : Boolean
        {
            return param1.proxyId1 == param2 && param1.proxyId2 == param3;
        }// end function

    }
}
