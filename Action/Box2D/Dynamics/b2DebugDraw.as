package Box2D.Dynamics
{
    import Box2D.Common.*;
    import Box2D.Common.Math.*;
    import flash.display.*;

    public class b2DebugDraw extends Object
    {
        public var m_xformScale:Number = 1;
        public var m_fillAlpha:Number = 1;
        public var m_alpha:Number = 1;
        public var m_lineThickness:Number = 1;
        public var m_drawFlags:uint;
        public var m_sprite:Sprite;
        public var m_drawScale:Number = 1;
        public static var e_coreShapeBit:uint = 4;
        public static var e_shapeBit:uint = 1;
        public static var e_centerOfMassBit:uint = 64;
        public static var e_aabbBit:uint = 8;
        public static var e_obbBit:uint = 16;
        public static var e_pairBit:uint = 32;
        public static var e_jointBit:uint = 2;

        public function b2DebugDraw()
        {
            m_drawScale = 1;
            m_lineThickness = 1;
            m_alpha = 1;
            m_fillAlpha = 1;
            m_xformScale = 1;
            m_drawFlags = 0;
            return;
        }// end function

        public function DrawSolidPolygon(param1:Array, param2:int, param3:b2Color) : void
        {
            var _loc_4:* = 0;
            m_sprite.graphics.lineStyle(m_lineThickness, param3.color, m_alpha);
            m_sprite.graphics.moveTo(param1[0].x * m_drawScale, param1[0].y * m_drawScale);
            m_sprite.graphics.beginFill(param3.color, m_fillAlpha);
            _loc_4 = 1;
            while (_loc_4 < param2)
            {
                
                m_sprite.graphics.lineTo(param1[_loc_4].x * m_drawScale, param1[_loc_4].y * m_drawScale);
                _loc_4++;
            }
            m_sprite.graphics.lineTo(param1[0].x * m_drawScale, param1[0].y * m_drawScale);
            m_sprite.graphics.endFill();
            return;
        }// end function

        public function DrawCircle(param1:b2Vec2, param2:Number, param3:b2Color) : void
        {
            m_sprite.graphics.lineStyle(m_lineThickness, param3.color, m_alpha);
            m_sprite.graphics.drawCircle(param1.x * m_drawScale, param1.y * m_drawScale, param2 * m_drawScale);
            return;
        }// end function

        public function DrawXForm(param1:b2XForm) : void
        {
            m_sprite.graphics.lineStyle(m_lineThickness, 16711680, m_alpha);
            m_sprite.graphics.moveTo(param1.position.x * m_drawScale, param1.position.y * m_drawScale);
            m_sprite.graphics.lineTo((param1.position.x + m_xformScale * param1.R.col1.x) * m_drawScale, (param1.position.y + m_xformScale * param1.R.col1.y) * m_drawScale);
            m_sprite.graphics.lineStyle(m_lineThickness, 65280, m_alpha);
            m_sprite.graphics.moveTo(param1.position.x * m_drawScale, param1.position.y * m_drawScale);
            m_sprite.graphics.lineTo((param1.position.x + m_xformScale * param1.R.col2.x) * m_drawScale, (param1.position.y + m_xformScale * param1.R.col2.y) * m_drawScale);
            return;
        }// end function

        public function ClearFlags(param1:uint) : void
        {
            m_drawFlags = m_drawFlags & ~param1;
            return;
        }// end function

        public function DrawSolidCircle(param1:b2Vec2, param2:Number, param3:b2Vec2, param4:b2Color) : void
        {
            m_sprite.graphics.lineStyle(m_lineThickness, param4.color, m_alpha);
            m_sprite.graphics.moveTo(0, 0);
            m_sprite.graphics.beginFill(param4.color, m_fillAlpha);
            m_sprite.graphics.drawCircle(param1.x * m_drawScale, param1.y * m_drawScale, param2 * m_drawScale);
            m_sprite.graphics.endFill();
            m_sprite.graphics.moveTo(param1.x * m_drawScale, param1.y * m_drawScale);
            m_sprite.graphics.lineTo((param1.x + param3.x * param2) * m_drawScale, (param1.y + param3.y * param2) * m_drawScale);
            return;
        }// end function

        public function SetFlags(param1:uint) : void
        {
            m_drawFlags = param1;
            return;
        }// end function

        public function AppendFlags(param1:uint) : void
        {
            m_drawFlags = m_drawFlags | param1;
            return;
        }// end function

        public function DrawSegment(param1:b2Vec2, param2:b2Vec2, param3:b2Color) : void
        {
            m_sprite.graphics.lineStyle(m_lineThickness, param3.color, m_alpha);
            m_sprite.graphics.moveTo(param1.x * m_drawScale, param1.y * m_drawScale);
            m_sprite.graphics.lineTo(param2.x * m_drawScale, param2.y * m_drawScale);
            return;
        }// end function

        public function GetFlags() : uint
        {
            return m_drawFlags;
        }// end function

        public function DrawPolygon(param1:Array, param2:int, param3:b2Color) : void
        {
            var _loc_4:* = 0;
            m_sprite.graphics.lineStyle(m_lineThickness, param3.color, m_alpha);
            m_sprite.graphics.moveTo(param1[0].x * m_drawScale, param1[0].y * m_drawScale);
            _loc_4 = 1;
            while (_loc_4 < param2)
            {
                
                m_sprite.graphics.lineTo(param1[_loc_4].x * m_drawScale, param1[_loc_4].y * m_drawScale);
                _loc_4++;
            }
            m_sprite.graphics.lineTo(param1[0].x * m_drawScale, param1[0].y * m_drawScale);
            return;
        }// end function

    }
}
