package 
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.SampleDataEvent;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.media.Microphone;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.SampleDataEvent;
	import flash.media.SoundTransform;
	import fl.events.SliderEvent;
	import flash.events.EventDispatcher;
	import fl.controls.Slider;

	public class sequences extends MovieClip
	{

		private var timer:Timer;
		private var countDownTimer:Timer;

		private var drumArray:Array;
		private var guitarArray:Array;
		private var clapArray:Array;
		private var heyArray:Array;
		private var tamtamArray:Array;
		private var saksArray:Array;
		private var pianoArray:Array;

		private var drumsound:Sound = new Sound();
		private var guitarsound:Sound = new Sound();
		private var clapsound:Sound = new Sound();
		private var heysound:Sound = new Sound();
		private var tamtamsound:Sound = new Sound();
		private var sakssound:Sound = new Sound();
		protected var mic:Microphone;
		protected var soundBytes:ByteArray;
		protected var sound:Sound = new Sound();
		protected var channel:SoundChannel = new SoundChannel();
		protected var s:Sound = new Sound();
		private var bmTransform:SoundTransform;
		private var bmPosition:Number;
		private var bmPlaying:Boolean;

		public function sequences()
		{

			// constructor code

			var drum:DrumSwitch;
			var guitar:GuiltarSwitch;
			var clap:ClapSwitch;
			var hey:HeySwitch;
			var tamtam:TamtamSwitch;
			var saks:SaksSwitch;
			var piano:PianoSwitch;

			drumArray = new Array();
			guitarArray = new Array();
			clapArray = new Array();
			heyArray = new Array();
			tamtamArray = new Array();
			saksArray = new Array();
			pianoArray = new Array();

			var s:Sound = new Sound();
			var sound:Sound = new Sound();

			soundBytes = new ByteArray();

			countDownTimer = new Timer(1000,1);
			countDownTimer.addEventListener(TimerEvent.TIMER, onCountDown);
			countDownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onCountDownComplete);

			// Event Listeners;
			recButton.addEventListener(MouseEvent.CLICK, doRecordCountDown);
			stpButton.addEventListener(MouseEvent.CLICK, doStopRecording);
			fresh.addEventListener(MouseEvent.CLICK, doRefresh);
			loopon.addEventListener(MouseEvent.CLICK, doLoop);
			loopoff.addEventListener(MouseEvent.CLICK, noLoop);
			s.addEventListener(Event.COMPLETE, playSoundLoaded);
			
			bmTransform = new SoundTransform(.5, 0);
			vol.addEventListener(SliderEvent.CHANGE, handleVolumeChange);

			//stpButton.visable = false;
			stpButton.alpha = 0;
			loopoff.alpha = 0;
			loopon.alpha = 1;
			//countDownMC.alpha = 0;
			now.alpha = 0;


			var reqdrum:URLRequest = new URLRequest("MP3/drum.mp3");
			drumsound.load(reqdrum);

			var reqguitar:URLRequest = new URLRequest("MP3/guitar.mp3");
			guitarsound.load(reqguitar);

			var reqclap:URLRequest = new URLRequest("MP3/clap.mp3");
			clapsound.load(reqclap);

			var reqhey:URLRequest = new URLRequest("MP3/hey.mp3");
			heysound.load(reqhey);

			var reqtamtam:URLRequest = new URLRequest("MP3/tamtam.mp3");
			tamtamsound.load(reqtamtam);

			var reqsaks:URLRequest = new URLRequest("MP3/saks.mp3");
			sakssound.load(reqsaks);


			for (var i:int=0; i < 16; i++)
			{
				// drum
				drum = new DrumSwitch();
				drum.x = 60 + (i * 30);
				drum.y = 40;

				drum.addEventListener(MouseEvent.CLICK, handledrumClick);

				drumArray.push(drum);

				this.addChild(drum);

				// guitar
				guitar = new GuiltarSwitch();
				guitar.x = 60 + (i * 30);
				guitar.y = 80;

				guitar.addEventListener(MouseEvent.CLICK, handleguitarClick);

				guitarArray.push(guitar);

				this.addChild(guitar);

				// clap
				clap = new ClapSwitch();
				clap.x = 60 + (i * 30);
				clap.y = 120;

				clap.addEventListener(MouseEvent.CLICK, handleclapClick);

				clapArray.push(clap);

				this.addChild(clap);

				//hey
				hey = new HeySwitch();
				hey.x = 60 + (i * 30);
				hey.y = 280;

				hey.addEventListener(MouseEvent.CLICK, handleheyClick);

				heyArray.push(hey);

				this.addChild(hey);

				//tamtam
				tamtam = new TamtamSwitch();
				tamtam.x = 60 + (i * 30);
				tamtam.y = 200;

				tamtam.addEventListener(MouseEvent.CLICK, handletamtamClick);

				tamtamArray.push(tamtam);

				this.addChild(tamtam);

				//tamtam
				saks = new SaksSwitch();
				saks.x = 60 + (i * 30);
				saks.y = 240;

				saks.addEventListener(MouseEvent.CLICK, handlesaksClick);

				saksArray.push(saks);

				this.addChild(saks);

				// process counter named piano
				piano = new PianoSwitch();
				piano.x = 60 + (i * 30);
				piano.y = 160;
				piano.alpha = 0;

				pianoArray.push(piano);

				this.addChild(piano);


			}

			// playing all
			playButton.addEventListener(MouseEvent.CLICK, handlePlayClick);

			timer = new Timer(1000,16);
			timer.addEventListener(TimerEvent.TIMER, handleTimerStep);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, handlerFinished);
		}

		private function playSoundLoaded(e:Event):void
		{

			var bmPosition:Number;
		}

		// timer back to 0
		private function handlerFinished(e:Event):void
		{
			timer.reset();
			
			if (loopoff.alpha == 1)
			{
				timer.start();
				handlePlayClick(null);
			}

		}


		// 1,2,3 button
		private function doRecordCountDown(theEvent:MouseEvent):void
		{
			//countDownMC.alpha = 1;
			stpButton.alpha = 1;
			//(countDownMC as MovieClip).gotoAndStop(1);
			countDownTimer.reset();
			countDownTimer.start();
		}

		private function onCountDown(e:Event):void
		{
			//(countDownMC as MovieClip).gotoAndStop(this.countDownTimer.currentCount+1);
		}

		private function doLoop(e:MouseEvent):void
		{
			trace( "loop on");
			loopoff.alpha = 1;
			loopon.alpha = 0;
			//timer.start();
			//s.play();

		}
		private function noLoop(e:MouseEvent):void
		{
			trace( "loop off");
			loopoff.alpha = 0;
			loopon.alpha = 1;
			timer.stop();
		}


		private function onCountDownComplete(e:Event):void
		{
			this.swapChildrenAt(1,2);
			now.alpha = 1;
			// microphone
			mic = Microphone.getMicrophone();

			soundBytes.clear();

			mic.setSilenceLevel(0, 4000);

			mic.gain = 50;

			mic.rate = 44;

			mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
		}

		function doStopRecording(theEvent:Event):void
		{
			// Switch to rec button
			this.swapChildrenAt(1,2);

			stpButton.alpha = 0;
			now.alpha = 0;
			mic = new Microphone();
			mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);

			soundBytes.position = 0;

			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);

			channel = sound.play();

			channel.addEventListener( Event.SOUND_COMPLETE, playbackComplete );


		}

		function micSampleDataHandler(event:SampleDataEvent):void
		{
			while (event.data.bytesAvailable)
			{

				var sample:Number = event.data.readFloat();

				soundBytes.writeFloat(sample);

			}
		}


		function playbackSampleHandler(event:SampleDataEvent):void
		{
			for (var i:int = 0; i < 8192 && soundBytes.bytesAvailable > 0; i++)
			{
				var sample:Number = soundBytes.readFloat();

				event.data.writeFloat(sample);
				event.data.writeFloat(sample);
			}
		}


		function playbackComplete( event:Event ):void
		{
			trace( "Playback finished.");
		}

		private function doRefresh(e:MouseEvent):void
		{
			trace("fresh");

			// reset buttons to 1
			for (var i:int=0; i < 16; i++)
			{
				drumArray[i].alpha = 1;

				guitarArray[i].alpha = 1;

				clapArray[i].alpha = 1;

				heyArray[i].alpha = 1;

				tamtamArray[i].alpha = 1;

				saksArray[i].alpha = 1;

				pianoArray[i].alpha = 0;
			}
		}

		// onclick set alpha to half
		private function handledrumClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}


		private function handleguitarClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}

		private function handleclapClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}

		private function handleheyClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}

		private function handletamtamClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}

		private function handlesaksClick(e:MouseEvent):void
		{
			e.target.alpha = 0.5;
		}

		private function handlePlayClick(e:MouseEvent):void
		{
			trace("playing");
			timer.start();
			var s:Sound = new Sound();

			s.addEventListener(Event.COMPLETE, playSound);

			var req:URLRequest = new URLRequest("MP3/BM.mp3");

			s.load(req);
			//channel = s.play(bmPosition,0,bmTransform);
			bmPlaying = true;
			if (! bmPlaying)
			{

				channel = s.play(bmPosition,0,bmTransform);
				bmPlaying = true;
			}
			else
			{
				bmPosition = channel.position;
				channel.stop();
				bmPlaying = false;
			}

		}

		private function handleVolumeChange(e:SliderEvent):void
		{
			trace(vol.value);
			trace(bmTransform.volume);
			bmTransform.volume = vol.value / 1000;

			channel.soundTransform = bmTransform;
		}

		function playSound(theEvent:Event):void
		{
			var s:Sound = theEvent.target as Sound;
			channel = s.play();
		}


		private function handleTimerStep(e:TimerEvent):void
		{
			trace("GO..." + timer.currentCount);

			// play instruments sounds
			if (drumArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("drum");
				drumsound.play();
			}

			if (guitarArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("guitar");
				guitarsound.play();
			}

			if (clapArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("clap");
				clapsound.play();
			}

			if (heyArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("hey");
				heysound.play();
			}

			if (tamtamArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("tamtam");
				tamtamsound.play();
			}

			if (saksArray[timer.currentCount - 1].alpha == 0.5)
			{
				trace("saks");
				sakssound.play();
			}
			if (pianoArray[timer.currentCount - 1].alpha == 0)
			{
				trace("process");
				pianoArray[timer.currentCount - 1].alpha = 1;

			}

		}


	}

}