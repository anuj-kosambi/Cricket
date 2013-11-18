package wck
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class TopSpinner extends MovieClip
    {
        public var def:b2BodyDef;
        public var GameOver:Boolean;
        public var HZ:Object;
        public var view1:DemoView1;
        public var HSval:Object;
        public var pointer:DemoCursor;
        public var cursor:Cursor;
        public var SRval:Object;
        public var cricketball:b2Body;
        public var scoreval:Object;
        public var world:World;
        public var shape:Shape;
        public var view:View;
        public var score:int;

        public function TopSpinner()
        {
            SRval = new TextField();
            scoreval = new TextField();
            HSval = new TextField();
            HZ = new Howzat();
            cursor = getChildByName("pointer") as Cursor;
            cursor.initialize();
            initView("view1");
            cursor.lock();
            addEventListener(Event.ENTER_FRAME, initialize, false, 0, true);
            GlobalVars.vars.highScore = 0;
            GlobalVars.vars.timeElapsed = 0;
            GlobalVars.vars.lastBallTime = 0;
            return;
        }// end function

        public function restart(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            if (GlobalVars.vars.GameOver == true)
            {
                stage.removeChild(DisplayObject(HZ));
                _loc_2 = view.world.b2world.GetBodyList();
                while (_loc_2)
                {
                    
                    _loc_4 = _loc_2;
                    _loc_2 = _loc_2.GetNext();
                    if (_loc_4.m_userData)
                    {
                        _loc_5 = _loc_4.m_userData;
                        if (_loc_5 is DisplayObject)
                        {
                            if (_loc_5.parent)
                            {
                                _loc_5.parent.removeChild(_loc_5);
                                _loc_4.m_userData = null;
                            }
                        }
                    }
                    view.world.b2world.DestroyBody(_loc_4);
                    _loc_4 = null;
                }
                view.cleanUp();
                world = null;
                view = null;
                view = new DemoView1();
                view.x = 275;
                view.y = 200;
                view.width = 875.6;
                view.height = 485.9;
                view.name = "view1";
                stage.addChild(view);
                _loc_3 = new DemoCursor();
                _loc_3.name = "pointer";
                _loc_3.x = 200;
                _loc_3.y = 200;
                addChild(_loc_3);
                cursor = new Cursor();
                cursor = _loc_3;
                cursor.initialize();
                stage.addChild(cursor);
                view.initialize();
                cursor.world = view.world;
                cursor.lock();
                initialize(event);
            }
            return;
        }// end function

        public function everyFrame(event:Event) : void
        {
            if (GlobalVars.vars.score > 0)
            {
                SRval.text = "Strike Rate: " + (Math.floor(100 * GlobalVars.vars.score / GlobalVars.vars.BallPlayedCount) / 100).toString();
            }
            else
            {
                SRval.text = "Strike Rate: 0";
            }
            scoreval.text = GlobalVars.vars.score.toString() + " runs";
            if (GlobalVars.vars.GameOver == true && GlobalVars.vars.GameEnded == false)
            {
                EndGame();
            }
            if (GlobalVars.vars.GameOver == false)
            {
                if (GlobalVars.vars.timeElapsed - GlobalVars.vars.lastBallTime > 2)
                {
                    newBall();
                    GlobalVars.vars.lastBallTime = GlobalVars.vars.timeElapsed;
                }
            }
            return;
        }// end function

        public function initialize(event:Event)
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            GlobalVars.vars.timeElapsed = 0;
            GlobalVars.vars.lastBallTime = 0;
            removeEventListener(Event.ENTER_FRAME, initialize);
            addEventListener(Event.ENTER_FRAME, everyFrame, false, 0, true);
            stage.addEventListener(MouseEvent.CLICK, restart, false, 0, true);
            GlobalVars.vars.score = 0;
            GlobalVars.vars.GameOver = false;
            GlobalVars.vars.GameEnded = false;
            GlobalVars.vars.BallCount = 0;
            GlobalVars.vars.BallPlayedCount = 0;
            GlobalVars.vars.TotalScore = 0;
            SRval.textColor = 16777215;
            SRval.selectable = false;
            SRval.x = -400;
            SRval.y = 350;
            SRval.width = 1000;
            SRval.height = 100;
            SRval.embedFonts = true;
            scoreval.x = -400;
            scoreval.y = 290;
            scoreval.width = 1000;
            scoreval.height = 100;
            scoreval.textColor = 16777215;
            scoreval.selectable = false;
            scoreval.embedFonts = true;
            HSval.x = -350;
            HSval.y = 320;
            HSval.width = 1000;
            HSval.height = 100;
            HSval.textColor = 11184810;
            HSval.selectable = false;
            HSval.embedFonts = true;
            _loc_2 = new TextFormat();
            _loc_2.bold = false;
            _loc_2.italic = false;
            _loc_2.size = 60;
            _loc_2.leading = 20;
            _loc_2.align = "center";
            _loc_2.font = "Gill Sans MT Pro Bold";
            _loc_3 = new TextFormat();
            _loc_3.bold = false;
            _loc_3.italic = false;
            _loc_3.size = 30;
            _loc_3.leading = 20;
            _loc_3.align = "right";
            _loc_3.font = "Gill Sans MT Pro Bold";
            SRval.setTextFormat(_loc_2);
            scoreval.setTextFormat(_loc_2);
            scoreval.defaultTextFormat = _loc_2;
            SRval.defaultTextFormat = _loc_2;
            HSval.setTextFormat(_loc_3);
            HSval.defaultTextFormat = _loc_3;
            if (GlobalVars.vars.score > 0)
            {
                SRval.text = "Strike Rate: " + (Math.floor(10 * GlobalVars.vars.score / GlobalVars.vars.BallCount) / 10).toString();
            }
            else
            {
                SRval.text = "Strike Rate: 0";
            }
            scoreval.text = GlobalVars.vars.score.toString() + " runs";
            view.world.addChild(SRval);
            view.world.addChild(scoreval);
            view.world.addChild(HSval);
            return;
        }// end function

        public function EndGame() : void
        {
            var _loc_1:* = null;
            GlobalVars.vars.GameEnded = true;
            if (GlobalVars.vars.BallPlayedCount > 0)
            {
                GlobalVars.vars.TotalScore = Math.floor(GlobalVars.vars.score * (Math.floor(100 * GlobalVars.vars.score / GlobalVars.vars.BallPlayedCount) / 100));
            }
            else
            {
                GlobalVars.vars.TotalScore = 0;
            }
            GlobalVars.vars.highScore = Math.max(GlobalVars.vars.TotalScore, GlobalVars.vars.highScore);
            HSval.text = "Best: " + GlobalVars.vars.highScore.toString();
            stage.addChild(HZ);
            HZ.RunSlot.textColor = 3355443;
            HZ.RunSlot.embedFonts = true;
            _loc_1 = new TextFormat();
            _loc_1.bold = false;
            _loc_1.size = 20;
            _loc_1.align = "center";
            _loc_1.font = "Gill Sans MT Pro Bold";
            HZ.RunSlot.defaultTextFormat = _loc_1;
            HZ.RunSlot.text = GlobalVars.vars.score.toString();
            HZ.StrikeSlot.textColor = 3355443;
            HZ.StrikeSlot.embedFonts = true;
            HZ.StrikeSlot.defaultTextFormat = _loc_1;
            HZ.ScoreSlot.textColor = 3355443;
            HZ.ScoreSlot.embedFonts = true;
            HZ.ScoreSlot.defaultTextFormat = _loc_1;
            if (GlobalVars.vars.BallPlayedCount > 0)
            {
                HZ.StrikeSlot.text = (Math.floor(100 * GlobalVars.vars.score / GlobalVars.vars.BallPlayedCount) / 100).toString();
            }
            else
            {
                HZ.StrikeSlot.text = "0";
            }
            HZ.ScoreSlot.text = GlobalVars.vars.TotalScore;
            HZ.x = 130;
            HZ.y = 100;
            return;
        }// end function

        public function newBall() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = GlobalVars.vars;
            var _loc_11:* = _loc_10.BallCount + 1;
            _loc_10.BallCount = _loc_11;
            _loc_1 = new b2BodyDef();
            _loc_1.userData = new Ball();
            _loc_1.userData.width = 35;
            _loc_1.userData.height = 35;
            _loc_1.userData.shapeCategoryBits = 2;
            _loc_1.userData.shapeMaskBits = 65531;
            _loc_1.userData.shapeRestitution = 0.5;
            _loc_1.userData.shapeFriction = 0.6;
            _loc_1.userData.shapeDensity = 2;
            _loc_1.userData.bodyAngularDamping = 0.8;
            _loc_1.userData.bodyAllowSleep = true;
            _loc_1.userData.bodyIsBullet = true;
            _loc_1.userData.bodyFixedRotation = false;
            _loc_1.userData.x = 750 + Math.random() * 100;
            _loc_1.userData.y = -150 + 200 * (Math.random() - 0.5);
            _loc_1.userData.name = "cball";
            _loc_2 = view.world.b2world.CreateBody(_loc_1) as b2Body;
            _loc_2.SetMassFromShapes();
            view.world.addChild(_loc_1.userData);
            _loc_1.userData.create();
            _loc_3 = view.world.b2world.m_bodyList;
            _loc_4 = _loc_1.userData.x - 750;
            _loc_5 = _loc_1.userData.y + 150;
            _loc_6 = Math.atan(_loc_5 / _loc_4);
            _loc_7 = new b2Vec2(Math.cos(_loc_6) * -10 - 10, Math.sin(_loc_6) * -5 + 2.5);
            _loc_8 = Math.atan(_loc_7.y / _loc_7.x) * 180 / Math.PI;
            _loc_3.SetLinearVelocity(_loc_7);
            _loc_9 = _loc_8 * 20 - _loc_7.x * 10 + 100;
            _loc_3.ApplyTorque(_loc_9);
            return;
        }// end function

        public function initView(param1) : void
        {
            if (view)
            {
                view.cleanUp();
            }
            view = getChildByName(param1) as View;
            view.initialize();
            cursor.world = view.world;
            return;
        }// end function

    }
}
