using Uno;
using Uno.UX;
using Uno.Compiler.ExportTargetInterop;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;
using Fuse.Controls.Native.iOS;
using RBT.Animation;

namespace RBT.Animation.Native.iOS
{
	extern(!iOS) class LottieView
	{
		[UXConstructor]
		public LottieView([UXParameter("Host")]RBT.Animation.ILottieEvents host) { }
	}

	[Require("Cocoapods.Podfile.Target", "pod 'lottie-ios', '~> 2.5.3' ")]
	[Require("Source.Import", "Lottie/Lottie.h")]
	extern(iOS) class LottieView : Fuse.Controls.Native.iOS.LeafView, ILottieView
	{
		RBT.Animation.ILottieEvents _host;

		[UXConstructor]
		public LottieView([UXParameter("Host")]RBT.Animation.ILottieEvents host) : base(Create())
		{
			_host = host;
		}

		/** EVENTS **/
		void onAnimationComplete(bool isComplete)
		{
			_host.onAnimationComplete(isComplete);
		}

		/** EVENT PROPERTIES **/
		//AnimationCompleted
		bool _AnimationCompletedValue = false;

		public bool AnimationCompleted
		{
			get { 
				return _AnimationCompletedValue; 
			}
			set { }
		}
		//EndAnimationCompleted





		/** PROPERTIES **/

		//AndroidImagesFolder
		string _AndroidImagesFolderValue = "";

		public string AndroidImagesFolder
		{
			get { return _AndroidImagesFolderValue; }
			set { 
				//Android only
			}
		}
		//EndAndroidImagesFolder

		//File
		string _UrlToJSONValue = "";

		public string File
		{
			get { return _UrlToJSONValue; }
			set { 
				_UrlToJSONValue = value;
				SetUrlToJSONValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetUrlToJSONValue(string urlToJSON, ObjC.Object lottieViewHandle)
		@{
			NSLog(@"File: %@", urlToJSON);

			if (![urlToJSON isEqualToString:@""]) {

				NSString *bundleFilename = @{GetBundleFilename(string):Call(urlToJSON)};

				if (![bundleFilename isEqualToString:@""]) {

					bundleFilename = @{GetFilenameWithoutExtension(string):Call(bundleFilename)};
					
					LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;

					//keep previous settings
					BOOL prevLoopAnimation = animationView.loopAnimation;
					BOOL prevAutoReverseAnimation = animationView.autoReverseAnimation;
					BOOL prevCacheEnable = animationView.cacheEnable;
					BOOL prevShouldRasterizeWhenIdle = animationView.shouldRasterizeWhenIdle;
					CGFloat prevAnimationSpeed = animationView.animationSpeed;
					UIViewContentMode prevContentMode = animationView.contentMode;
					BOOL isAnimationPlaying = animationView.isAnimationPlaying;

					[animationView setAnimationNamed: [NSString stringWithFormat:@"%@%@", @"data/", bundleFilename] ];

					//restore previous settings
					animationView.loopAnimation = prevLoopAnimation;
					animationView.autoReverseAnimation = prevAutoReverseAnimation;
					animationView.cacheEnable = prevCacheEnable;
					animationView.shouldRasterizeWhenIdle = prevShouldRasterizeWhenIdle;
					animationView.animationSpeed = prevAnimationSpeed;
					animationView.contentMode = prevContentMode;

					if (isAnimationPlaying == 1) {
						animationView.animationProgress = 0;
						[animationView play];
					}
					// animationView.loopAnimation = YES;
					// animationView.contentMode = UIViewContentModeScaleAspectFill;

					// [animationView play];
				}
			}
		@}
		//EndFile


		//ContentMode
		string _ContentModeValue = "";

		public string ContentMode
		{
			get { 
				return _ContentModeValue; 
			}
			set { 
				_ContentModeValue = value;
				SetContentModeValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetContentModeValue(string contentMode, ObjC.Object lottieViewHandle)
		@{

			if (![contentMode isEqualToString:@""]) {

				LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;

				if ([[contentMode lowercaseString] isEqualToString:@"scaletofill"]) {
					animationView.contentMode = UIViewContentModeScaleToFill;
				} else if ([[contentMode lowercaseString] isEqualToString:@"scaleaspectfit"]) {
					animationView.contentMode = UIViewContentModeScaleAspectFit;
				} else if ([[contentMode lowercaseString] isEqualToString:@"scaleaspectfill"]) {
					animationView.contentMode = UIViewContentModeScaleAspectFill;
				} else if ([[contentMode lowercaseString] isEqualToString:@"redraw"]) {
					animationView.contentMode = UIViewContentModeRedraw;
				} else if ([[contentMode lowercaseString] isEqualToString:@"center"]) {
					animationView.contentMode = UIViewContentModeCenter;
				} else if ([[contentMode lowercaseString] isEqualToString:@"top"]) {
					animationView.contentMode = UIViewContentModeTop;
				} else if ([[contentMode lowercaseString] isEqualToString:@"bottom"]) {
					animationView.contentMode = UIViewContentModeBottom;
				} else if ([[contentMode lowercaseString] isEqualToString:@"left"]) {
					animationView.contentMode = UIViewContentModeLeft;
				} else if ([[contentMode lowercaseString] isEqualToString:@"right"]) {
					animationView.contentMode = UIViewContentModeRight;
				} else if ([[contentMode lowercaseString] isEqualToString:@"topleft"]) {
					animationView.contentMode = UIViewContentModeTopLeft;
				} else if ([[contentMode lowercaseString] isEqualToString:@"topright"]) {
					animationView.contentMode = UIViewContentModeTopRight;
				} else if ([[contentMode lowercaseString] isEqualToString:@"bottomleft"]) {
					animationView.contentMode = UIViewContentModeBottomLeft;
				} else if ([[contentMode lowercaseString] isEqualToString:@"bottomright"]) {
					animationView.contentMode = UIViewContentModeBottomRight;
				}
			}
		@}
		//EndContentMode


		//IsAnimationPlaying
		bool _IsAnimationPlayingValue = false;
		public bool IsAnimationPlaying
		{
			get { 
				_IsAnimationPlayingValue = GetIsAnimationPlayingValue(Handle);
				return _IsAnimationPlayingValue; 
			}
			set {  }
		}

		[Foreign(Language.ObjC)]
		bool GetIsAnimationPlayingValue(ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			return (animationView.isAnimationPlaying == 1);
		@}
		//EndIsAnimationPlaying


		//LoopAnimation
		bool _LoopAnimationValue = false;

		public bool LoopAnimation
		{
			get { 
				_LoopAnimationValue = GetLoopAnimationValue(Handle);
				return GetLoopAnimationValue(Handle);
			}
			set { 
				_LoopAnimationValue = value;
				SetLoopAnimationValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		bool GetLoopAnimationValue(ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			return (animationView.loopAnimation == 1);
		@}

		[Foreign(Language.ObjC)]
		void SetLoopAnimationValue(bool loopAnimation, ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			animationView.loopAnimation = loopAnimation;
		@}
		//EndLoopAnimation


		//AutoReverseAnimation
		bool _AutoReverseAnimationValue = false;

		public bool AutoReverseAnimation
		{
			get { 
				_AutoReverseAnimationValue = GetAutoReverseAnimationValue(Handle);
				return GetAutoReverseAnimationValue(Handle);
			}
			set { 
				_AutoReverseAnimationValue = value;
				SetAutoReverseAnimationValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		bool GetAutoReverseAnimationValue(ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			return (animationView.autoReverseAnimation == 1);
		@}

		[Foreign(Language.ObjC)]
		void SetAutoReverseAnimationValue(bool autoReverseAnimation, ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			animationView.autoReverseAnimation = autoReverseAnimation;
			if (animationView.isAnimationPlaying == 1) {
				[animationView pause];
				@{LottieView:Of(_this).onAnimationComplete(bool):Call(false)};
				[animationView playWithCompletion:^(BOOL animationFinished) {
					
					@{LottieView:Of(_this).onAnimationComplete(bool):Call(true)};
				}];
			}
		@}
		//EndAutoReverseAnimation


		//Play
		bool _PlayValue = false;

		public bool Play
		{
			get { 
				return _PlayValue;
			}
			set { 
				_PlayValue = value;
				SetPlayValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetPlayValue(bool play, ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			if (play) {
				//[animationView play];
				[animationView playWithCompletion:^(BOOL animationFinished) {
					
					@{LottieView:Of(_this).onAnimationComplete(bool):Call(true)};
				}];

			}
		@}
		//EndPlay


		//Pause
		bool _PauseValue = false;

		public bool Pause
		{
			get { 
				return _PauseValue;
			}
			set { 
				_PauseValue = value;
				SetPauseValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetPauseValue(bool pause, ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			if (pause) {
				[animationView pause];
			}
		@}
		//EndPause


		//Stop
		bool _StopValue = false;

		public bool Stop
		{
			get { 
				return _StopValue;
			}
			set { 
				_StopValue = value;
				SetStopValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetStopValue(bool stop, ObjC.Object lottieViewHandle)
		@{
			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;
			if (stop) {
				[animationView stop];
			}
		@}
		//EndStop


		//Progress
		float _ProgressValue = 0f;

		public float Progress
		{
			get { 
				return _ProgressValue; 
			}
			set { 
				_ProgressValue = value;
				SetProgressValue(value, Handle); 
			}
		}

		[Foreign(Language.ObjC)]
		void SetProgressValue(float progress, ObjC.Object lottieViewHandle)
		@{

			LOTAnimationView *animationView = (LOTAnimationView *)lottieViewHandle;

			animationView.animationProgress = progress;
			
		@}
		//EndProgress

		/** ENDPROPERTIES **/











		//Utils
		public static string GetBundleFilename(string imagePath)
		{

			var bundlePath = "";
			foreach(var f in Uno.IO.Bundle.AllFiles)
			{
				//debug_log("SourcePath: " + f.SourcePath);

				if (f.SourcePath == imagePath) {
					
					var bundleFileSource = new Uno.UX.BundleFileSource(f);

					//var bundleFileSource = fileSource as BundleFileSource;
					if (bundleFileSource != null) {
						bundlePath = bundleFileSource.BundleFile.BundlePath;
						break;
					} else {
						bundlePath = "";
					}
				}
			}

			return bundlePath;
		}


		public static string GetFilenameWithoutExtension(string path)
		{
			string[] details = path.Split('/');
			details = details[details.Length-1].Split('.');

			return details[0];
		}


		public override void Dispose()
		{
			base.Dispose();
			_host = null;
		}


		public void OnRooted()
		{
			// Do nothing
		}

		public void OnUnrooted()
		{
			// Do nothing
		}

		[Foreign(Language.ObjC)]
		static ObjC.Object Create()
		@{
			LOTAnimationView *animationView = [[LOTAnimationView alloc] init];
			animationView.contentMode = UIViewContentModeScaleAspectFit;
			return animationView;

		@}

	}

}
