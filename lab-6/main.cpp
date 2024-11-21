#include <iostream>
#include <stdio.h>


#include <libusb/include/libusb.h>


using namespace std;


static void print_device(libusb_device *dev, libusb_device_handle *handle = NULL);

int main(){

    libusb_context *ctx = NULL;
    int ret;


    ret = libusb_init(&ctx);
    if (ret < 0){
        cerr << "Error: initialization failed, code: " << ret << "." << endl;
        return 1;
    }

    libusb_set_option(ctx, LIBUSB_OPTION_LOG_LEVEL, LIBUSB_LOG_LEVEL_INFO);


    libusb_device **devs;
    ssize_t cnt;
    cnt = libusb_get_device_list(ctx, &devs);
    if (cnt < 0) {
        cerr << "Error: The list of USB devices has not been received." << endl;
        return 1;
    }

    cout << "Number of devices found: " << cnt << endl;
    for (ssize_t i = 0; i < cnt; i++) {
        cout << "Device #" << i + 1 << " info:" << endl;
        print_device(devs[i]);
    }

    libusb_free_device_list(devs, 1);
    
    libusb_exit(ctx);

    return 0;
}

static void print_device(libusb_device *dev, libusb_device_handle *handle)
{
	struct libusb_device_descriptor desc;
	unsigned char string[256];
	int ret;

	ret = libusb_get_device_descriptor(dev, &desc);
	if (ret < 0) {
		cerr << "failed to get device descriptor" << endl;
		return;
	}

	if (!handle)
		libusb_open(dev, &handle);

	if (handle) {
		if (desc.iManufacturer) {
			ret = libusb_get_string_descriptor_ascii(handle, desc.iManufacturer, string, sizeof(string));
			if (ret > 0) {
				cout << "\tManufacturer:              " << string << endl;
            }
		}

		if (desc.iProduct) {
			ret = libusb_get_string_descriptor_ascii(handle, desc.iProduct, string, sizeof(string));
			if (ret > 0) {
				cout << "\tProduct:                   " << string << endl;
            }
		}

		if (desc.iSerialNumber) {
			ret = libusb_get_string_descriptor_ascii(handle, desc.iSerialNumber, string, sizeof(string));
			if (ret > 0) {
				cout << "\tSerial Number:             " << string << endl;
            }
		}
        cout << endl;
	}
    else {
        cout << "\tThe device information could not be opened.\n"
             << "\tMost likely, it does not have a driver for interaction or its version is outdated.\n"
             << "\tCheck the device driver and try again" 
             << endl;
    }

	if (handle)
		libusb_close(handle);
}
